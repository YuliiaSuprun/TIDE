import os

def generate_pddl_problem(num_blocks, directory):
    # Create the file content
    objects = " ".join(f"b{i}" for i in range(1, num_blocks + 1)) + " - block"
    init = " ".join(f"(ontable b{i}) (clear b{i})" for i in range(1, num_blocks + 1))
    # Goal for first stage: stack blocks in order
    goal_initial = " ".join(f"(on b{i+1} b{i})" for i in range(1, num_blocks))
    # Goal for second stage: reorder with the lowest block (b1) on top
    goal_next = " ".join(f"(on b{i} b{i-1})" for i in range(num_blocks, 2, -1)) + f" (on b1 b{num_blocks})"
    
    content = f"""(define (problem bw_{num_blocks})
  (:domain blocks-domain)
  (:objects {objects})
  (:init (emptyhand) {init})
  
  (:goal
    (eventually (and 
      {goal_initial}
      (next (eventually (and
        {goal_next}
      )))))
  )
)
"""
    # Create directory if it doesn't exist
    os.makedirs(directory, exist_ok=True)
    
    # Define the file path
    file_path = os.path.join(directory, f"m{num_blocks}.pddl")
    
    # Write the content to the file
    with open(file_path, "w") as f:
        f.write(content)
    
    print(f"Generated: {file_path}")

def main():
    # Define the range of blocks and the output directory
    start, end = 3, 50
    output_directory = "/home/pack-a-punch/Documents/Programming/yuliia/ResearchCode/Task-Planning-with-TEGs/docker_dir/data/deterministic/LTLf/S24/blocksworld/"
    
    # Generate files for each number of blocks
    for i in range(start, end + 1):
        generate_pddl_problem(i, output_directory)

if __name__ == "__main__":
    main()
