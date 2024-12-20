/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output, and Bison version.  */
#define YYBISON 30802

/* Bison version string.  */
#define YYBISON_VERSION "3.8.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1


/* Substitute the variable and function names.  */
#define yyparse         fct_pddlparse
#define yylex           fct_pddllex
#define yyerror         fct_pddlerror
#define yydebug         fct_pddldebug
#define yynerrs         fct_pddlnerrs
#define yylval          fct_pddllval
#define yychar          fct_pddlchar

/* First part of user prologue.  */
#line 1 "scan-fct_pddl.y"

#ifdef YYDEBUG
  extern int yydebug=1;
#endif


#include <stdio.h>
#include <string.h> 
#include "bb.h"
#include "memory.h"
#include "parse.h"


#ifndef SCAN_ERR
#define SCAN_ERR
#define DEFINE_EXPECTED            0
#define PROBLEM_EXPECTED           1
#define PROBNAME_EXPECTED          2
#define LBRACKET_EXPECTED          3
#define RBRACKET_EXPECTED          4
#define DOMDEFS_EXPECTED           5
#define REQUIREM_EXPECTED          6
#define TYPEDLIST_EXPECTED         7
#define DOMEXT_EXPECTED            8
#define DOMEXTNAME_EXPECTED        9
#define TYPEDEF_EXPECTED          10
#define CONSTLIST_EXPECTED        11
#define PREDDEF_EXPECTED          12 
#define NAME_EXPECTED             13
#define VARIABLE_EXPECTED         14
#define ACTIONFUNCTOR_EXPECTED    15
#define ATOM_FORMULA_EXPECTED     16
#define EFFECT_DEF_EXPECTED       17
#define NEG_FORMULA_EXPECTED      18
#define NOT_SUPPORTED             19
#define SITUATION_EXPECTED        20
#define SITNAME_EXPECTED          21
#define BDOMAIN_EXPECTED          22
#define BADDOMAIN                 23
#define INIFACTS                  24
#define GOALDEF                   25
#define ADLGOAL                   26
#endif


static char * serrmsg[] = {
  "'define' expected",
  "'problem' expected",
  "problem name expected",
  "'(' expected",
  "')' expected",
  "additional domain definitions expected",
  "requirements (e.g. ':strips') expected",
  "typed list of <%s> expected",
  "domain extension expected",
  "domain to be extented expected",
  "type definition expected",
  "list of constants expected",
  "predicate definition expected",
  "<name> expected",
  "<variable> expected",
  "action functor expected",
  "atomic formula expected",
  "effect definition expected",
  "negated atomic formula expected",
  "requirement %s not supported by this IPP version",  
  "'situation' expected",
  "situation name expected",
  "':domain' expected",
  "this problem needs another domain file",
  "initial facts definition expected",
  "goal definition expected",
  "first order logic expression expected",
  NULL
};


void fcterr( int errno, char *par );


static int sact_err;
static char *sact_err_par = NULL;
static Bool sis_negated = FALSE;


#line 164 "scan-fct_pddl.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif


/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int fct_pddldebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    DEFINE_TOK = 258,              /* DEFINE_TOK  */
    PROBLEM_TOK = 259,             /* PROBLEM_TOK  */
    SITUATION_TOK = 260,           /* SITUATION_TOK  */
    BSITUATION_TOK = 261,          /* BSITUATION_TOK  */
    OBJECTS_TOK = 262,             /* OBJECTS_TOK  */
    BDOMAIN_TOK = 263,             /* BDOMAIN_TOK  */
    INIT_TOK = 264,                /* INIT_TOK  */
    GOAL_TOK = 265,                /* GOAL_TOK  */
    AND_TOK = 266,                 /* AND_TOK  */
    NOT_TOK = 267,                 /* NOT_TOK  */
    NAME = 268,                    /* NAME  */
    VARIABLE = 269,                /* VARIABLE  */
    TYPE = 270,                    /* TYPE  */
    EQUAL_TOK = 271,               /* EQUAL_TOK  */
    FORALL_TOK = 272,              /* FORALL_TOK  */
    IMPLY_TOK = 273,               /* IMPLY_TOK  */
    OR_TOK = 274,                  /* OR_TOK  */
    EXISTS_TOK = 275,              /* EXISTS_TOK  */
    EITHER_TOK = 276,              /* EITHER_TOK  */
    OPEN_PAREN = 277,              /* OPEN_PAREN  */
    CLOSE_PAREN = 278              /* CLOSE_PAREN  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 91 "scan-fct_pddl.y"


  char string[MAX_LENGTH];
  char* pstring;
  PlNode* pPlNode;
  FactList* pFactList;
  TokenList* pTokenList;


#line 244 "scan-fct_pddl.tab.c"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE fct_pddllval;


int fct_pddlparse (void);



/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_DEFINE_TOK = 3,                 /* DEFINE_TOK  */
  YYSYMBOL_PROBLEM_TOK = 4,                /* PROBLEM_TOK  */
  YYSYMBOL_SITUATION_TOK = 5,              /* SITUATION_TOK  */
  YYSYMBOL_BSITUATION_TOK = 6,             /* BSITUATION_TOK  */
  YYSYMBOL_OBJECTS_TOK = 7,                /* OBJECTS_TOK  */
  YYSYMBOL_BDOMAIN_TOK = 8,                /* BDOMAIN_TOK  */
  YYSYMBOL_INIT_TOK = 9,                   /* INIT_TOK  */
  YYSYMBOL_GOAL_TOK = 10,                  /* GOAL_TOK  */
  YYSYMBOL_AND_TOK = 11,                   /* AND_TOK  */
  YYSYMBOL_NOT_TOK = 12,                   /* NOT_TOK  */
  YYSYMBOL_NAME = 13,                      /* NAME  */
  YYSYMBOL_VARIABLE = 14,                  /* VARIABLE  */
  YYSYMBOL_TYPE = 15,                      /* TYPE  */
  YYSYMBOL_EQUAL_TOK = 16,                 /* EQUAL_TOK  */
  YYSYMBOL_FORALL_TOK = 17,                /* FORALL_TOK  */
  YYSYMBOL_IMPLY_TOK = 18,                 /* IMPLY_TOK  */
  YYSYMBOL_OR_TOK = 19,                    /* OR_TOK  */
  YYSYMBOL_EXISTS_TOK = 20,                /* EXISTS_TOK  */
  YYSYMBOL_EITHER_TOK = 21,                /* EITHER_TOK  */
  YYSYMBOL_OPEN_PAREN = 22,                /* OPEN_PAREN  */
  YYSYMBOL_CLOSE_PAREN = 23,               /* CLOSE_PAREN  */
  YYSYMBOL_YYACCEPT = 24,                  /* $accept  */
  YYSYMBOL_file = 25,                      /* file  */
  YYSYMBOL_problem_definition = 26,        /* problem_definition  */
  YYSYMBOL_27_1 = 27,                      /* $@1  */
  YYSYMBOL_problem_name = 28,              /* problem_name  */
  YYSYMBOL_base_domain_name = 29,          /* base_domain_name  */
  YYSYMBOL_problem_defs = 30,              /* problem_defs  */
  YYSYMBOL_objects_def = 31,               /* objects_def  */
  YYSYMBOL_init_def = 32,                  /* init_def  */
  YYSYMBOL_33_2 = 33,                      /* $@2  */
  YYSYMBOL_goal_def = 34,                  /* goal_def  */
  YYSYMBOL_35_3 = 35,                      /* $@3  */
  YYSYMBOL_adl_goal_description = 36,      /* adl_goal_description  */
  YYSYMBOL_adl_goal_description_star = 37, /* adl_goal_description_star  */
  YYSYMBOL_literal_term = 38,              /* literal_term  */
  YYSYMBOL_atomic_formula_term = 39,       /* atomic_formula_term  */
  YYSYMBOL_term_star = 40,                 /* term_star  */
  YYSYMBOL_term = 41,                      /* term  */
  YYSYMBOL_name_plus = 42,                 /* name_plus  */
  YYSYMBOL_typed_list_name = 43,           /* typed_list_name  */
  YYSYMBOL_typed_list_variable = 44,       /* typed_list_variable  */
  YYSYMBOL_predicate = 45,                 /* predicate  */
  YYSYMBOL_literal_name_plus = 46,         /* literal_name_plus  */
  YYSYMBOL_literal_name = 47,              /* literal_name  */
  YYSYMBOL_atomic_formula_name = 48,       /* atomic_formula_name  */
  YYSYMBOL_name_star = 49                  /* name_star  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;




#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

/* Work around bug in HP-UX 11.23, which defines these macros
   incorrectly for preprocessor constants.  This workaround can likely
   be removed in 2023, as HPE has promised support for HP-UX 11.23
   (aka HP-UX 11i v2) only through the end of 2022; see Table 2 of
   <https://h20195.www2.hpe.com/V2/getpdf.aspx/4AA4-7673ENW.pdf>.  */
#ifdef __hpux
# undef UINT_LEAST8_MAX
# undef UINT_LEAST16_MAX
# define UINT_LEAST8_MAX 255
# define UINT_LEAST16_MAX 65535
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_int8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if !defined yyoverflow

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* !defined yyoverflow */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  5
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   104

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  24
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  26
/* YYNRULES -- Number of rules.  */
#define YYNRULES  52
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  110

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   278


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23
};

#if YYDEBUG
/* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   144,   144,   147,   154,   153,   169,   179,   189,   192,
     194,   196,   198,   204,   234,   233,   248,   247,   265,   278,
     284,   290,   296,   306,   348,   390,   394,   405,   411,   420,
     432,   436,   447,   453,   463,   470,   482,   484,   537,   549,
     574,   576,   627,   639,   663,   669,   679,   684,   693,   703,
     713,   725,   727
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if YYDEBUG || 0
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end of file\"", "error", "\"invalid token\"", "DEFINE_TOK",
  "PROBLEM_TOK", "SITUATION_TOK", "BSITUATION_TOK", "OBJECTS_TOK",
  "BDOMAIN_TOK", "INIT_TOK", "GOAL_TOK", "AND_TOK", "NOT_TOK", "NAME",
  "VARIABLE", "TYPE", "EQUAL_TOK", "FORALL_TOK", "IMPLY_TOK", "OR_TOK",
  "EXISTS_TOK", "EITHER_TOK", "OPEN_PAREN", "CLOSE_PAREN", "$accept",
  "file", "problem_definition", "$@1", "problem_name", "base_domain_name",
  "problem_defs", "objects_def", "init_def", "$@2", "goal_def", "$@3",
  "adl_goal_description", "adl_goal_description_star", "literal_term",
  "atomic_formula_term", "term_star", "term", "name_plus",
  "typed_list_name", "typed_list_variable", "predicate",
  "literal_name_plus", "literal_name", "atomic_formula_name", "name_star", YY_NULLPTR
};

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  return yytname[yysymbol];
}
#endif

#define YYPACT_NINF (-74)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
static const yytype_int8 yypact[] =
{
     -14,    12,    19,   -14,   -74,   -74,   -74,     3,    39,    10,
      36,    27,    10,    29,    10,    10,    10,    30,    37,    41,
     -74,   -74,   -74,   -74,   -74,   -74,   -74,   -74,    -4,    32,
      33,    35,    38,    37,    45,   -74,   -74,   -74,    15,    40,
      35,   -74,    28,    42,   -74,   -74,   -74,    45,    43,    46,
     -74,   -74,    48,   -74,   -74,    38,    38,    49,    38,    38,
      50,    16,   -74,   -74,    37,    -3,    47,    48,    51,    38,
      52,    53,    54,    59,    38,    55,    59,   -74,   -74,    56,
      16,   -74,   -74,   -74,   -74,   -74,   -74,   -74,   -74,    -9,
      57,    58,   -74,    60,   -74,   -74,    59,    45,   -74,    38,
     -74,    38,   -74,    61,    62,    63,    59,   -74,   -74,   -74
};

/* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE does not specify something else to do.  Zero
   means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       2,     0,     0,     2,     4,     1,     3,     0,     0,     8,
       0,     0,     8,     0,     8,     8,     8,     0,    36,     0,
      14,    16,    12,     5,     9,    10,    11,     6,    36,     0,
       0,     0,     0,    36,     0,    39,    13,     7,     0,     0,
      46,    49,     0,     0,    18,    28,    38,    34,     0,     0,
      44,    45,    51,    15,    47,    25,     0,     0,     0,    25,
       0,    30,    17,    35,    36,     0,     0,    51,     0,    25,
       0,     0,     0,    40,     0,     0,    40,    32,    33,     0,
      30,    37,    48,    52,    50,    26,    19,    21,    27,    40,
       0,     0,    20,     0,    29,    31,    40,     0,    43,     0,
      22,     0,    42,     0,     0,     0,    40,    24,    23,    41
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -74,    79,   -74,   -74,   -74,   -74,     6,   -74,   -74,   -74,
     -74,   -74,   -32,   -55,   -74,     8,   -21,   -74,   -46,   -26,
     -73,    20,    64,   -74,    44,    21
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
       0,     2,     3,     7,     9,    12,    13,    14,    15,    31,
      16,    32,    69,    70,    44,    45,    79,    80,    48,    29,
      90,    52,    39,    40,    41,    68
};

/* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule whose
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int8 yytable[] =
{
      43,    63,    35,    93,    75,    89,    96,    46,     1,    28,
      50,    33,    97,    51,    85,     4,    98,    34,    22,     5,
      24,    25,    26,   102,    71,     8,    74,    49,    50,    77,
      78,    51,    11,   109,    18,    19,    20,    21,    81,    55,
      56,    50,    91,    10,    51,    57,    58,    59,    60,    17,
      28,   103,    23,    27,    30,    36,    37,    38,    47,    95,
      42,    67,    61,    53,    72,    62,    64,   104,    65,   105,
      82,    73,    76,    89,    84,    86,    87,    88,    92,    94,
      99,   100,     6,   101,   106,   107,   108,     0,    83,     0,
       0,     0,     0,    66,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,    54
};

static const yytype_int8 yycheck[] =
{
      32,    47,    28,    76,    59,    14,    15,    33,    22,    13,
      13,    15,    21,    16,    69,     3,    89,    21,    12,     0,
      14,    15,    16,    96,    56,    22,    58,    12,    13,    13,
      14,    16,    22,   106,     7,     8,     9,    10,    64,    11,
      12,    13,    74,     4,    16,    17,    18,    19,    20,    13,
      13,    97,    23,    23,    13,    23,    23,    22,    13,    80,
      22,    13,    42,    23,    56,    23,    23,    99,    22,   101,
      23,    22,    22,    14,    23,    23,    23,    23,    23,    23,
      23,    23,     3,    23,    23,    23,    23,    -1,    67,    -1,
      -1,    -1,    -1,    49,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    40
};

/* YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
   state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,    22,    25,    26,     3,     0,    25,    27,    22,    28,
       4,    22,    29,    30,    31,    32,    34,    13,     7,     8,
       9,    10,    30,    23,    30,    30,    30,    23,    13,    43,
      13,    33,    35,    15,    21,    43,    23,    23,    22,    46,
      47,    48,    22,    36,    38,    39,    43,    13,    42,    12,
      13,    16,    45,    23,    46,    11,    12,    17,    18,    19,
      20,    45,    23,    42,    23,    22,    48,    13,    49,    36,
      37,    36,    39,    22,    36,    37,    22,    13,    14,    40,
      41,    43,    23,    49,    23,    37,    23,    23,    23,    14,
      44,    36,    23,    44,    23,    40,    15,    21,    44,    23,
      23,    23,    44,    42,    36,    36,    23,    23,    23,    44
};

/* YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr1[] =
{
       0,    24,    25,    25,    27,    26,    28,    29,    30,    30,
      30,    30,    30,    31,    33,    32,    35,    34,    36,    36,
      36,    36,    36,    36,    36,    37,    37,    38,    38,    39,
      40,    40,    41,    41,    42,    42,    43,    43,    43,    43,
      44,    44,    44,    44,    45,    45,    46,    46,    47,    47,
      48,    49,    49
};

/* YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     0,     2,     0,     6,     4,     4,     0,     2,
       2,     2,     2,     4,     0,     5,     0,     5,     1,     4,
       4,     4,     5,     7,     7,     0,     2,     4,     1,     4,
       0,     2,     1,     1,     1,     2,     0,     5,     3,     2,
       0,     5,     3,     2,     1,     1,     1,     2,     4,     1,
       4,     0,     2
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYNOMEM         goto yyexhaustedlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)




# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YY_USE (yyoutput);
  if (!yyvaluep)
    return;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp,
                 int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)]);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif






/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep)
{
  YY_USE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* Lookahead token kind.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;




/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY; /* Cause a token to be read.  */

  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    YYNOMEM;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        YYNOMEM;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          YYNOMEM;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */


  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      goto yyerrlab1;
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 4: /* $@1: %empty  */
#line 154 "scan-fct_pddl.y"
{ 
  fcterr( PROBNAME_EXPECTED, NULL ); 
}
#line 1340 "scan-fct_pddl.tab.c"
    break;

  case 5: /* problem_definition: OPEN_PAREN DEFINE_TOK $@1 problem_name problem_defs CLOSE_PAREN  */
#line 158 "scan-fct_pddl.y"
{  
  gproblem_name = (yyvsp[-2].pstring);
  if ( gcmd_line.display_info >= 1 ) {
    printf("\nproblem '%s' defined\n", gproblem_name);
  }
}
#line 1351 "scan-fct_pddl.tab.c"
    break;

  case 6: /* problem_name: OPEN_PAREN PROBLEM_TOK NAME CLOSE_PAREN  */
#line 170 "scan-fct_pddl.y"
{ 
  (yyval.pstring) = new_Token( strlen((yyvsp[-1].string))+1 );
  strcpy((yyval.pstring), (yyvsp[-1].string));
}
#line 1360 "scan-fct_pddl.tab.c"
    break;

  case 7: /* base_domain_name: OPEN_PAREN BDOMAIN_TOK NAME CLOSE_PAREN  */
#line 180 "scan-fct_pddl.y"
{ 
  if ( SAME != strcmp((yyvsp[-1].string), gdomain_name) ) {
    fcterr( BADDOMAIN, NULL );
    yyerror();
  }
}
#line 1371 "scan-fct_pddl.tab.c"
    break;

  case 13: /* objects_def: OPEN_PAREN OBJECTS_TOK typed_list_name CLOSE_PAREN  */
#line 205 "scan-fct_pddl.y"
{ 
  FactList *f;
  type_tree root;
  type_tree_list ttl;

  if ( gorig_constant_list ) {
    for ( f = gorig_constant_list; f->next; f = f->next );
    f->next = (yyvsp[-1].pFactList);
  } else {
    gorig_constant_list = (yyvsp[-1].pFactList);
  }
  /* maybe new types are introduced here and must be added to the
   * type tree 
   */
  for ( f = gorig_constant_list; f; f = f->next ) {
    root = main_type_tree(); /* do not search the EITHER trees */
    if ( !find_branch( f->item->next->item, root ) ) { /* type of this constant is not known yet */
      ttl = new_type_tree_list( f->item->next->item );
      ttl->next = root->sub_types;
      root->sub_types = ttl;
    }
  }
}
#line 1399 "scan-fct_pddl.tab.c"
    break;

  case 14: /* $@2: %empty  */
#line 234 "scan-fct_pddl.y"
{
  fcterr( INIFACTS, NULL ); 
}
#line 1407 "scan-fct_pddl.tab.c"
    break;

  case 15: /* init_def: OPEN_PAREN INIT_TOK $@2 literal_name_plus CLOSE_PAREN  */
#line 238 "scan-fct_pddl.y"
{
  gorig_initial_facts = new_PlNode(AND);
  gorig_initial_facts->sons = (yyvsp[-1].pPlNode);
}
#line 1416 "scan-fct_pddl.tab.c"
    break;

  case 16: /* $@3: %empty  */
#line 248 "scan-fct_pddl.y"
{ 
  fcterr( GOALDEF, NULL ); 
}
#line 1424 "scan-fct_pddl.tab.c"
    break;

  case 17: /* goal_def: OPEN_PAREN GOAL_TOK $@3 adl_goal_description CLOSE_PAREN  */
#line 252 "scan-fct_pddl.y"
{
  (yyvsp[-1].pPlNode)->next = gorig_goal_facts;
  gorig_goal_facts = (yyvsp[-1].pPlNode);
}
#line 1433 "scan-fct_pddl.tab.c"
    break;

  case 18: /* adl_goal_description: literal_term  */
#line 266 "scan-fct_pddl.y"
{ 
  if ( sis_negated ) {
    (yyval.pPlNode) = new_PlNode(NOT);
    (yyval.pPlNode)->sons = new_PlNode(ATOM);
    (yyval.pPlNode)->sons->atom = (yyvsp[0].pTokenList);
    sis_negated = FALSE;
  } else {
    (yyval.pPlNode) = new_PlNode(ATOM);
    (yyval.pPlNode)->atom = (yyvsp[0].pTokenList);
  }
}
#line 1449 "scan-fct_pddl.tab.c"
    break;

  case 19: /* adl_goal_description: OPEN_PAREN AND_TOK adl_goal_description_star CLOSE_PAREN  */
#line 279 "scan-fct_pddl.y"
{ 
  (yyval.pPlNode) = new_PlNode(AND);
  (yyval.pPlNode)->sons = (yyvsp[-1].pPlNode);
}
#line 1458 "scan-fct_pddl.tab.c"
    break;

  case 20: /* adl_goal_description: OPEN_PAREN OR_TOK adl_goal_description_star CLOSE_PAREN  */
#line 285 "scan-fct_pddl.y"
{ 
  (yyval.pPlNode) = new_PlNode(OR);
  (yyval.pPlNode)->sons = (yyvsp[-1].pPlNode);
}
#line 1467 "scan-fct_pddl.tab.c"
    break;

  case 21: /* adl_goal_description: OPEN_PAREN NOT_TOK adl_goal_description CLOSE_PAREN  */
#line 291 "scan-fct_pddl.y"
{ 
  (yyval.pPlNode) = new_PlNode(NOT);
  (yyval.pPlNode)->sons = (yyvsp[-1].pPlNode);
}
#line 1476 "scan-fct_pddl.tab.c"
    break;

  case 22: /* adl_goal_description: OPEN_PAREN IMPLY_TOK adl_goal_description adl_goal_description CLOSE_PAREN  */
#line 297 "scan-fct_pddl.y"
{ 
  PlNode *np = new_PlNode(NOT);
  np->sons = (yyvsp[-2].pPlNode);
  np->next = (yyvsp[-1].pPlNode);

  (yyval.pPlNode) = new_PlNode(OR);
  (yyval.pPlNode)->sons = np;
}
#line 1489 "scan-fct_pddl.tab.c"
    break;

  case 23: /* adl_goal_description: OPEN_PAREN EXISTS_TOK OPEN_PAREN typed_list_variable CLOSE_PAREN adl_goal_description CLOSE_PAREN  */
#line 309 "scan-fct_pddl.y"
{ 
  /* The typed_list_variable returns a FactList with two-item TokenLists, 
   * the first item is the variable and the second item its type.
   * We now have to split off this FactList into a PlNode for each 
   * variable-type TokenList. 
   */
  FactList *tl = (yyvsp[-3].pFactList), *t1;
  PlNode *pln1;
  PlNode *pln2;

  pln1 = new_PlNode(EX);
  pln1->atom = tl->item;
  (yyval.pPlNode) = pln1;

  t1 = tl;
  /* every loop gives us one quantor with one variable and its type 
   */
  while ( t1->next ) {
    t1 = t1->next;
    
    pln2 = new_PlNode(EX);
    pln2->atom = t1->item;
    /* append the next quantor to the sons of the previous node 
     */
    pln1->sons = pln2;
    pln1 = pln2;
  }
  pln1->sons = (yyvsp[-1].pPlNode);

  t1 = tl->next;
  while ( TRUE ) {
    free ( tl );
    if ( !t1 ) break;
    tl = t1;
    t1 = tl->next;
  }

}
#line 1532 "scan-fct_pddl.tab.c"
    break;

  case 24: /* adl_goal_description: OPEN_PAREN FORALL_TOK OPEN_PAREN typed_list_variable CLOSE_PAREN adl_goal_description CLOSE_PAREN  */
#line 351 "scan-fct_pddl.y"
{ 
  /* This will be handled exactly like the ex-quantor case, s.a. 
   */
  FactList *tl = (yyvsp[-3].pFactList), *t1;
  PlNode *pln1;
  PlNode *pln2;
  
  pln1 = new_PlNode(ALL);
  pln1->atom = tl->item;
  (yyval.pPlNode) = pln1;

  t1 = tl;
  /* every loop gives us one quantor with one variable and its type 
   */
  while ( t1->next ) {
    t1 = t1->next;
    
    pln2 = new_PlNode(ALL);
    pln2->atom = t1->item;
    pln1->sons = pln2;
    pln1 = pln2;
  }
  pln1->sons = (yyvsp[-1].pPlNode);

  t1 = tl->next;
  while ( TRUE ) {
    free ( tl );
    if ( !t1 ) break;
    tl = t1;
    t1 = tl->next;
  }

}
#line 1570 "scan-fct_pddl.tab.c"
    break;

  case 25: /* adl_goal_description_star: %empty  */
#line 390 "scan-fct_pddl.y"
{
  (yyval.pPlNode) = NULL;
}
#line 1578 "scan-fct_pddl.tab.c"
    break;

  case 26: /* adl_goal_description_star: adl_goal_description adl_goal_description_star  */
#line 395 "scan-fct_pddl.y"
{
  (yyvsp[-1].pPlNode)->next = (yyvsp[0].pPlNode);
  (yyval.pPlNode) = (yyvsp[-1].pPlNode);
}
#line 1587 "scan-fct_pddl.tab.c"
    break;

  case 27: /* literal_term: OPEN_PAREN NOT_TOK atomic_formula_term CLOSE_PAREN  */
#line 406 "scan-fct_pddl.y"
{ 
  (yyval.pTokenList) = (yyvsp[-1].pTokenList);
  sis_negated = TRUE;
}
#line 1596 "scan-fct_pddl.tab.c"
    break;

  case 28: /* literal_term: atomic_formula_term  */
#line 412 "scan-fct_pddl.y"
{
  (yyval.pTokenList) = (yyvsp[0].pTokenList);
}
#line 1604 "scan-fct_pddl.tab.c"
    break;

  case 29: /* atomic_formula_term: OPEN_PAREN predicate term_star CLOSE_PAREN  */
#line 421 "scan-fct_pddl.y"
{ 
  (yyval.pTokenList) = new_TokenList();
  (yyval.pTokenList)->item = (yyvsp[-2].pstring);
  (yyval.pTokenList)->next = (yyvsp[-1].pTokenList);
}
#line 1614 "scan-fct_pddl.tab.c"
    break;

  case 30: /* term_star: %empty  */
#line 432 "scan-fct_pddl.y"
{
  (yyval.pTokenList) = NULL;
}
#line 1622 "scan-fct_pddl.tab.c"
    break;

  case 31: /* term_star: term term_star  */
#line 437 "scan-fct_pddl.y"
{
  (yyval.pTokenList) = new_TokenList();
  (yyval.pTokenList)->item = (yyvsp[-1].pstring);
  (yyval.pTokenList)->next = (yyvsp[0].pTokenList);
}
#line 1632 "scan-fct_pddl.tab.c"
    break;

  case 32: /* term: NAME  */
#line 448 "scan-fct_pddl.y"
{ 
  (yyval.pstring) = new_Token(strlen((yyvsp[0].string)) + 1);
  strcpy((yyval.pstring), (yyvsp[0].string));
}
#line 1641 "scan-fct_pddl.tab.c"
    break;

  case 33: /* term: VARIABLE  */
#line 454 "scan-fct_pddl.y"
{ 
  (yyval.pstring) = new_Token(strlen((yyvsp[0].string)) + 1);
  strcpy((yyval.pstring), (yyvsp[0].string));
}
#line 1650 "scan-fct_pddl.tab.c"
    break;

  case 34: /* name_plus: NAME  */
#line 464 "scan-fct_pddl.y"
{
  (yyval.pTokenList) = new_TokenList();
  (yyval.pTokenList)->item = new_Token(strlen((yyvsp[0].string)) + 1);
  strcpy((yyval.pTokenList)->item, (yyvsp[0].string));
}
#line 1660 "scan-fct_pddl.tab.c"
    break;

  case 35: /* name_plus: NAME name_plus  */
#line 471 "scan-fct_pddl.y"
{
  (yyval.pTokenList) = new_TokenList();
  (yyval.pTokenList)->item = new_Token(strlen((yyvsp[-1].string)) + 1);
  strcpy((yyval.pTokenList)->item, (yyvsp[-1].string));
  (yyval.pTokenList)->next = (yyvsp[0].pTokenList);
}
#line 1671 "scan-fct_pddl.tab.c"
    break;

  case 36: /* typed_list_name: %empty  */
#line 482 "scan-fct_pddl.y"
{ (yyval.pFactList) = NULL; }
#line 1677 "scan-fct_pddl.tab.c"
    break;

  case 37: /* typed_list_name: NAME EITHER_TOK name_plus CLOSE_PAREN typed_list_name  */
#line 485 "scan-fct_pddl.y"
{ /* this is a very, very special case... it may mean that
   * a. a parameter has one of the types in name_plus
   * b. a type is subtype of one of the following types in name_plus 
   * => for both possibilities we use the same solution:
   * build a new type name: either_name1_name2_..._namen and check
   * if a type with this name already exists. If so then NAME has this type,
   * if not then build a new type, include it in the type tree and
   * return NAME with the new type 
   * The new artificial type is not a subtype of OBJECT because its own
   * elements must already be instances of a subtype of OBJECT 
   */
  char *s;
  TokenList *t;
  type_tree tt;
  type_tree_list rootl, *st;
  
  s = new_Token( MAX_LENGTH );
  strcpy( s, EITHER_STR );
  for ( t = (yyvsp[-2].pTokenList); t; t = t->next ) {
    strcat( s, CONNECTOR );
    strcat( s, t->item );
  }
  tt = NULL;
  for ( rootl = gglobal_type_tree_list; rootl; rootl = rootl->next ) {
    if ((tt = find_branch( s, rootl->item ))) break;
  }

  if ( !tt ) { /* the type doesn't exist yet, so build it */
    rootl = new_type_tree_list( s );
    rootl->next = gglobal_type_tree_list;
    st = &(rootl->item->sub_types);
    for ( t = (yyvsp[-2].pTokenList); t; t = t->next ) {
      if ((tt = find_branch(t->item, main_type_tree()))) {
	*st = new_type_tree_list( NULL );
	(*st)->item = tt;
	st = &((*st)->next);
      }
    }  
  }

  /* now do the simple stuff: return a name with a (quite complicated)
   * type 
   */
  (yyval.pFactList) = new_FactList();
  (yyval.pFactList)->item = new_TokenList();
  (yyval.pFactList)->item->item = new_Token( strlen((yyvsp[-4].string))+1 );
  strcpy( (yyval.pFactList)->item->item, (yyvsp[-4].string) );
  (yyval.pFactList)->item->next = new_TokenList();
  (yyval.pFactList)->item->next->item = s;
  (yyval.pFactList)->next = (yyvsp[0].pFactList);
}
#line 1733 "scan-fct_pddl.tab.c"
    break;

  case 38: /* typed_list_name: NAME TYPE typed_list_name  */
#line 538 "scan-fct_pddl.y"
{
  (yyval.pFactList) = new_FactList();
  (yyval.pFactList)->item = new_TokenList();
  (yyval.pFactList)->item->item = new_Token( strlen((yyvsp[-2].string))+1 );
  strcpy( (yyval.pFactList)->item->item, (yyvsp[-2].string) );
  (yyval.pFactList)->item->next = new_TokenList();
  (yyval.pFactList)->item->next->item = new_Token( strlen((yyvsp[-1].string))+1 );
  strcpy( (yyval.pFactList)->item->next->item, (yyvsp[-1].string) );
  (yyval.pFactList)->next = (yyvsp[0].pFactList);
}
#line 1748 "scan-fct_pddl.tab.c"
    break;

  case 39: /* typed_list_name: NAME typed_list_name  */
#line 550 "scan-fct_pddl.y"
{
  (yyval.pFactList) = new_FactList();
  (yyval.pFactList)->item = new_TokenList();
  (yyval.pFactList)->item->item = new_Token( strlen((yyvsp[-1].string))+1 );
  strcpy( (yyval.pFactList)->item->item, (yyvsp[-1].string) );
  (yyval.pFactList)->item->next = new_TokenList();
  if ( (yyvsp[0].pFactList) ) {/* another element (already typed) is following */
    char *s = (yyvsp[0].pFactList)->item->next->item;
    int l = strlen( s ) + 1;
    (yyval.pFactList)->item->next->item = new_Token( l );
    strcpy( (yyval.pFactList)->item->next->item, s ); /* same type as the next one */
    (yyval.pFactList)->next = (yyvsp[0].pFactList);
  } else {/* no further element - it must be an untyped list */
    (yyval.pFactList)->item->next->item = new_Token( strlen(STANDARD_TYPE)+1 );
    strcpy( (yyval.pFactList)->item->next->item, STANDARD_TYPE );
    (yyval.pFactList)->next = (yyvsp[0].pFactList);
  }
}
#line 1771 "scan-fct_pddl.tab.c"
    break;

  case 40: /* typed_list_variable: %empty  */
#line 574 "scan-fct_pddl.y"
{ (yyval.pFactList) = NULL; }
#line 1777 "scan-fct_pddl.tab.c"
    break;

  case 41: /* typed_list_variable: VARIABLE EITHER_TOK name_plus CLOSE_PAREN typed_list_variable  */
#line 577 "scan-fct_pddl.y"
{ /* this is a very, very special case... it may mean that
   * a parameter has one of the types in name_plus
   * => build a new type name: either_name1_name2_..._namen and check
   * if a type with this name already exists. If so then NAME has this type,
   * if not then build a new type, include it in the type tree and
   * return NAME with the new type 
   * The new artificial type is not a subtype of OBJECT because its own
   * elements must already be instances of a subtype of OBJECT 
   */
  char *s;
  TokenList *t;
  type_tree tt;
  type_tree_list rootl, *st;
  
  s = new_Token( MAX_LENGTH );
  strcpy( s, EITHER_STR );
  for ( t = (yyvsp[-2].pTokenList); t; t = t->next ) {
    strcat( s, CONNECTOR );
    strcat( s, t->item );
  }
  tt = NULL;
  for ( rootl = gglobal_type_tree_list; rootl; rootl = rootl->next ) {
    if ((tt = find_branch( s, rootl->item))) break;
  }
  if ( !tt ) { /* the type doesn't exist yet, so build it */
    rootl = new_type_tree_list( s );
    rootl->next = gglobal_type_tree_list;
    st = &(rootl->item->sub_types);
    for ( t = (yyvsp[-2].pTokenList); t; t = t->next ) {
      if ((tt = find_branch( t->item, main_type_tree()))) {
	*st = new_type_tree_list( NULL );
	(*st)->item = tt;
	st = &((*st)->next);
      }
    }  
    gglobal_type_tree_list = rootl;
  }

  /* now do the simple stuff: return a name with a (quite complicated)
   * type 
   */
  (yyval.pFactList) = new_FactList();
  (yyval.pFactList)->item = new_TokenList();
  (yyval.pFactList)->item->item = new_Token( strlen((yyvsp[-4].string))+1 );
  strcpy( (yyval.pFactList)->item->item, (yyvsp[-4].string) );
  (yyval.pFactList)->item->next = new_TokenList();
  (yyval.pFactList)->item->next->item = s;
  (yyval.pFactList)->next = (yyvsp[0].pFactList);
}
#line 1831 "scan-fct_pddl.tab.c"
    break;

  case 42: /* typed_list_variable: VARIABLE TYPE typed_list_variable  */
#line 628 "scan-fct_pddl.y"
{
  (yyval.pFactList) = new_FactList();
  (yyval.pFactList)->item = new_TokenList();
  (yyval.pFactList)->item->item = new_Token( strlen((yyvsp[-2].string))+1 );
  strcpy( (yyval.pFactList)->item->item, (yyvsp[-2].string) );
  (yyval.pFactList)->item->next = new_TokenList();
  (yyval.pFactList)->item->next->item = new_Token( strlen((yyvsp[-1].string))+1 );
  strcpy( (yyval.pFactList)->item->next->item, (yyvsp[-1].string) );
  (yyval.pFactList)->next = (yyvsp[0].pFactList);
}
#line 1846 "scan-fct_pddl.tab.c"
    break;

  case 43: /* typed_list_variable: VARIABLE typed_list_variable  */
#line 640 "scan-fct_pddl.y"
{
  (yyval.pFactList) = new_FactList();
  (yyval.pFactList)->item = new_TokenList();
  (yyval.pFactList)->item->item = new_Token( strlen((yyvsp[-1].string))+1 );
  strcpy( (yyval.pFactList)->item->item, (yyvsp[-1].string) );
  (yyval.pFactList)->item->next = new_TokenList();
  if ( (yyvsp[0].pFactList) ) {/* another element (already typed) is following */
    char *s = (yyvsp[0].pFactList)->item->next->item;
    int l = strlen( s );
    (yyval.pFactList)->item->next->item = new_Token( l+1 );
    strcpy( (yyval.pFactList)->item->next->item, s ); /* same type as the next one */
    (yyval.pFactList)->next = (yyvsp[0].pFactList);
  } else {/* no further element - it must be an untyped list */
    (yyval.pFactList)->item->next->item = new_Token( strlen(STANDARD_TYPE)+1 );
    strcpy( (yyval.pFactList)->item->next->item, STANDARD_TYPE );
    (yyval.pFactList)->next = (yyvsp[0].pFactList);
  }
}
#line 1869 "scan-fct_pddl.tab.c"
    break;

  case 44: /* predicate: NAME  */
#line 664 "scan-fct_pddl.y"
{ 
  (yyval.pstring) = new_Token(strlen((yyvsp[0].string)) + 1);
  strcpy((yyval.pstring), (yyvsp[0].string));
}
#line 1878 "scan-fct_pddl.tab.c"
    break;

  case 45: /* predicate: EQUAL_TOK  */
#line 670 "scan-fct_pddl.y"
{ 
  (yyval.pstring) = new_Token( strlen(EQ_STR)+1 );
  strcpy( (yyval.pstring), EQ_STR );
}
#line 1887 "scan-fct_pddl.tab.c"
    break;

  case 46: /* literal_name_plus: literal_name  */
#line 680 "scan-fct_pddl.y"
{
  (yyval.pPlNode) = (yyvsp[0].pPlNode);
}
#line 1895 "scan-fct_pddl.tab.c"
    break;

  case 47: /* literal_name_plus: literal_name literal_name_plus  */
#line 685 "scan-fct_pddl.y"
{
   (yyval.pPlNode) = (yyvsp[-1].pPlNode);
   (yyval.pPlNode)->next = (yyvsp[0].pPlNode);
}
#line 1904 "scan-fct_pddl.tab.c"
    break;

  case 48: /* literal_name: OPEN_PAREN NOT_TOK atomic_formula_name CLOSE_PAREN  */
#line 694 "scan-fct_pddl.y"
{ 
  PlNode *tmp;

  tmp = new_PlNode(ATOM);
  tmp->atom = (yyvsp[-1].pTokenList);
  (yyval.pPlNode) = new_PlNode(NOT);
  (yyval.pPlNode)->sons = tmp;
}
#line 1917 "scan-fct_pddl.tab.c"
    break;

  case 49: /* literal_name: atomic_formula_name  */
#line 704 "scan-fct_pddl.y"
{
  (yyval.pPlNode) = new_PlNode(ATOM);
  (yyval.pPlNode)->atom = (yyvsp[0].pTokenList);
}
#line 1926 "scan-fct_pddl.tab.c"
    break;

  case 50: /* atomic_formula_name: OPEN_PAREN predicate name_star CLOSE_PAREN  */
#line 714 "scan-fct_pddl.y"
{ 
  (yyval.pTokenList) = new_TokenList();
  (yyval.pTokenList)->item = (yyvsp[-2].pstring);
  (yyval.pTokenList)->next = (yyvsp[-1].pTokenList);
}
#line 1936 "scan-fct_pddl.tab.c"
    break;

  case 51: /* name_star: %empty  */
#line 725 "scan-fct_pddl.y"
{ (yyval.pTokenList) = NULL; }
#line 1942 "scan-fct_pddl.tab.c"
    break;

  case 52: /* name_star: NAME name_star  */
#line 728 "scan-fct_pddl.y"
{
  (yyval.pTokenList) = new_TokenList();
  (yyval.pTokenList)->item = new_Token(strlen((yyvsp[-1].string)) + 1);
  strcpy((yyval.pTokenList)->item, (yyvsp[-1].string));
  (yyval.pTokenList)->next = (yyvsp[0].pTokenList);
}
#line 1953 "scan-fct_pddl.tab.c"
    break;


#line 1957 "scan-fct_pddl.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      yyerror (YY_("syntax error"));
    }

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;
  ++yynerrs;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  YY_ACCESSING_SYMBOL (yystate), yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturnlab;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturnlab;


/*-----------------------------------------------------------.
| yyexhaustedlab -- YYNOMEM (memory exhaustion) comes here.  |
`-----------------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturnlab;


/*----------------------------------------------------------.
| yyreturnlab -- parsing is finished, clean up and return.  |
`----------------------------------------------------------*/
yyreturnlab:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif

  return yyresult;
}

#line 737 "scan-fct_pddl.y"



#include "lex.fct_pddl.c"


/**********************************************************************
 * Functions
 **********************************************************************/


/* 
 * call	bison -pfct -bscan-fct scan-fct.y
 */
void fcterr( int errno, char *par ) {

  sact_err = errno;

  if ( sact_err_par ) {
    free( sact_err_par );
  }
  if ( par ) {
    sact_err_par = new_Token( strlen(par)+1 );
    strcpy( sact_err_par, par);
  } else {
    sact_err_par = NULL;
  }

}



int yyerror( char *msg )

{
  fflush( stdout );
  fprintf(stderr,"\n%s: syntax error in line %d, '%s':\n", 
	  gact_filename, lineno, yytext );

  if ( sact_err_par ) {
    fprintf(stderr, "%s%s\n", serrmsg[sact_err], sact_err_par );
  } else {
    fprintf(stderr,"%s\n", serrmsg[sact_err] );
  }

  exit( 1 );

}



void load_fct_file( char *filename ) 

{

  FILE *fp;/* pointer to input files */
  char tmp[MAX_LENGTH] = "";

  /* open fact file 
   */
  if( ( fp = fopen( filename, "r" ) ) == NULL ) {
    sprintf(tmp, "\nff: can't find fact file: %s\n\n", filename );
    perror(tmp);
    exit ( 1 );
  }

  gact_filename = filename;
  lineno = 1; 
  yyin = fp;

  yyparse();

  fclose( fp );/* and close file again */

}

