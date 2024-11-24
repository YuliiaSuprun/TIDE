/* Author: Zachary Kingston */

#include <pddlboat/utility.hpp>

#include <boost/regex.hpp>
#include <boost/lexical_cast.hpp>
#include <boost/chrono/chrono.hpp>
#include <boost/uuid/uuid.hpp>
#include <boost/uuid/uuid_generators.hpp>
#include <boost/uuid/uuid_io.hpp>
#include <fstream>

using namespace pddlboat;

std::string log::formatRecurse(boost::format &f)
{
    return f.str();
}

boost::filesystem::path io::expandHome(const boost::filesystem::path &in)
{
    const char *home = std::getenv("HOME");
    if (home == nullptr)
    {
        std::cerr << "HOME Environment variable is not set! Cannot resolve ~ in path." << std::endl;
        return in;
    }

    boost::filesystem::path out;
    for (const auto &p : in)
        out /= (p.string() == "~") ? home : p;

    return out;
}

boost::filesystem::path io::expandSymlinks(const boost::filesystem::path &in)
{
    boost::filesystem::path out;
    for (const auto &p : in)
    {
        auto tmp = out / p;
        if (boost::filesystem::is_symlink(tmp))
            out = boost::filesystem::read_symlink(tmp);
        else
            out /= p;
    }

    return out;
}

boost::filesystem::path io::expandPath(const boost::filesystem::path &in)
{
    boost::filesystem::path out = in;
    out = expandHome(out);
    out = expandSymlinks(out);

    return boost::filesystem::absolute(out);
}

// is lhs a prefix of rhs?
bool io::isPrefix(const std::string &lhs, const std::string &rhs)
{
    return std::equal(lhs.begin(), lhs.begin() + std::min(lhs.size(), rhs.size()), rhs.begin());
}

// is lhs a suffix? of rhs?
bool io::isSuffix(const std::string &lhs, const std::string &rhs)
{
    return std::equal(lhs.rbegin(), lhs.rbegin() + std::min(lhs.size(), rhs.size()), rhs.rbegin());
}

bool io::isExtension(const std::string &path_string, const std::string &extension)
{
    boost::filesystem::path path(path_string);
    const std::string last = boost::filesystem::extension(path);
    return isSuffix(extension, last);
}

std::string io::concatenatePaths(const std::string &first, const std::string &second)
{
    boost::filesystem::path f1(first), f2(second);
    f1 /= f2;

    return boost::filesystem::canonical(boost::filesystem::absolute(f1)).string();
}

std::string io::resolvePath(const std::string &path)
{
    boost::filesystem::path file(path);

    if (!fileExists(path))
    {
        std::cerr << log::format("File `%1%` does not exist.", path) << std::endl;
        return "";
    }

    return boost::filesystem::canonical(boost::filesystem::absolute(file)).string();
}

std::string io::loadFileToString(const std::string &path)
{
    const std::string full_path = resolvePath(path);
    if (full_path.empty())
        return "";

    std::ifstream ifs(full_path.c_str(), std::ios::in | std::ios::binary | std::ios::ate);

    std::ifstream::pos_type size = ifs.tellg();
    ifs.seekg(0, std::ios::beg);

    std::vector<char> bytes(size);
    ifs.read(bytes.data(), size);

    return std::string(bytes.data(), size);
}

std::optional<std::string> io::runCommand(const std::string &cmd)
{
    std::array<char, 128> buffer;
    std::string result;
    // std::shared_ptr<FILE> pipe(popen(cmd.c_str(), "r"), pclose);
    // Redirect stderr to stdout by appending " 2>&1" to the command
    std::shared_ptr<FILE> pipe(popen((cmd + " 2>&1").c_str(), "r"), pclose);
    if (!pipe)
    {
        std::cerr << log::format("Failed to run command `%1%`!", cmd) << std::endl;
        return std::nullopt;
    }

    while (!feof(pipe.get()))
    {
        if (fgets(buffer.data(), 128, pipe.get()) != nullptr)
            result += buffer.data();
    }
    
    // // Close the pipe and get the exit status
    // int exit_status = pclose(pipe.get());

    // // Check if the exit status indicates a command error (non-zero)
    // if (WIFEXITED(exit_status) && WEXITSTATUS(exit_status) != 0)
    // {
    //     int exit_code = WEXITSTATUS(exit_status);
    //     if (exit_code != 12) {
    //         std::cerr << log::format("Command `%1%` failed with exit code %2%! Output: `%3%`", cmd, exit_code, result) << std::endl;
    //     }
    //     return std::nullopt;
    // }
    // If exit status is normal, return the output
    return std::optional{result};
}

void io::createFile(std::ofstream &out, const std::string &file)
{
    boost::filesystem::path path(file);
    path = expandHome(path);
    path = expandSymlinks(path);

    const auto parent = path.parent_path().string();

    if (!parent.empty())
        boost::filesystem::create_directories(parent);

    out.open(path.string(), std::ofstream::out | std::ofstream::trunc);
}

bool io::deleteFile(const std::string &file)
{
    boost::filesystem::path path(file);
    path = expandHome(path);
    path = expandSymlinks(path);

    return boost::filesystem::remove(path);
}

std::optional<std::vector<std::string>> io::listDirectory(const std::string &directory)
{
    std::vector<std::string> contents;

    const std::string full_path = resolvePath(directory);
    if (full_path.empty())
        return std::nullopt;

    boost::filesystem::path path(full_path);
    if (not boost::filesystem::is_directory(path))
        return std::nullopt;

    for (auto it = boost::filesystem::directory_iterator(path); it != boost::filesystem::directory_iterator();
         ++it)
        contents.emplace_back(expandPath(it->path()).string());

    return std::optional{contents};
}

std::optional<std::vector<std::string>> io::glob(const std::string &directory, const std::string &wildcard)
{
    auto contents = listDirectory(directory);
    if (not contents)
        return std::nullopt;

    std::vector<std::string> matches;

    const boost::regex filter(wildcard);

    for (const auto &entry : *contents)
    {
        boost::filesystem::path path(entry);

        // Skip if not a file
        if (not boost::filesystem::is_regular_file(path))
            continue;

        boost::smatch what;
        if (not boost::regex_match(path.filename().string(), what, filter))
            continue;

        // File matches, store it
        matches.emplace_back(entry);
    }

    return std::optional{matches};
}

std::string io::generateUUID()
{
    boost::uuids::random_generator gen;
    boost::uuids::uuid u = gen();

    return boost::lexical_cast<std::string>(u);
}

std::string io::getTiming(const boost::timer::cpu_timer &timer)
{
    const auto elapsed = timer.elapsed();
    boost::chrono::duration<double> wall = boost::chrono::nanoseconds(elapsed.wall);
    boost::chrono::duration<double> user = boost::chrono::nanoseconds(elapsed.user);
    boost::chrono::duration<double> syst = boost::chrono::nanoseconds(elapsed.system);

    return log::format("Wall: %1%s, User: %2%s, System: %3%s",  //
                       wall.count(), user.count(), syst.count());
}

unsigned int io::getElapsedMilliseconds(const boost::timer::cpu_timer &timer)
{
    return boost::chrono::duration_cast<boost::chrono::milliseconds>(  //
               boost::chrono::nanoseconds(timer.elapsed().wall))
        .count();
}

std::string io::getResourceDirectory(const std::string &list)
{
    std::size_t last = 0;
    std::size_t next = 0;
    while ((next = list.find(":", last)) != std::string::npos)
    {
        boost::filesystem::path path(list.substr(last, next - last));

        if (fileExists(path.string()))
            return path.string();

        last = next + 1;
    }

    return list.substr(last);
}

bool io::fileExists(const std::string &filename) {
    // Use boost::filesystem to check for file existence
    boost::filesystem::path path(filename);
    return boost::filesystem::exists(expandPath(path)); // Returns true if file exists
}
