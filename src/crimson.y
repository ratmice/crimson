
// FIXME missing strings.
%token ID NUM
%start Source
%%
Source:
    | Prelude Expr
    ;

Prelude:
      TyDecls
    ;

InnerAttr: '#' '!' '[' Attr ']';
OuterAttr: '#' '[' Attr ']';

TyDecls:
    | InnerAttr TyDecls
    | OuterAttr TyDecl ';' TyDecls
    | TyDeclOpt ';' TyDecls
    ;

Attr:
    ID '=' Expr
    | ID '(' Expr ')'
    ;

TyDeclOpt:
    | TyDecl
    ;

TyDecl:
    'struct' ID TyOpt '{' Fields '}'
    ;

Fields:
    | ID ':' Ty ',' Fields
    | ID ':' Ty
    ;

Expr:
    Ty Expr
    | Unit
    | Unordered
    | Ordered
    | Value
    ;

Unit:
    '(' ')'
    ;


// Sets, HashTables
///////////////////
// In prehistory KvSeq had a # prefix, e.g.
//
// #{ foo = 0, bar = 1 }
//
// This is perhaps worth resurrecting since it means that we can distinguish
// #{} from {}
//
// As it is though you have 2 options:
// 1. Deserializer's choice
// 2. Serializer sends an explicit type.


Unordered:
    '{' '}'
    | '{' ExprSeq '}'
    | '{' KvSeq '}'
    ;

// Array
////////
// See comment about # prefix
Ordered:
    '[' ']'
    | '[' ExprSeq ']'
    // The equivalent of an Ordered key value data structure would be some bare form of a tree
    // Acting like an array of tuples, It is probably best to just encode this explicitly as a array of tuples,
    // or explicitly as a struct.
    // 
    // Essentially it would allow you to write:
    // [(1, "foo"), (0, "bar")]
    // as [1 = "foo", 0 = "bar"]
    // 
    // I don't really see any motiviation for including it though...
    // | '[' KvSeq ']'
    ;

ExprSeq: Expr ExprComma;
MaybeExprSeq: | ExprSeq;
ExprComma: | "," MaybeExprSeq;

KvSeq: Expr '=' Expr KvComma;
MaybeKvSeq: | KvSeq;
KvComma: | ',' MaybeKvSeq;

Value:
      ID
    | NUM
    | NUM '..' NUM
    ;

TyOpt:
    | Ty
    ;
Ty:
   '<' TypeExpr '>'
   ;

TypeExpr:
     ID
   | ID '<' TypeExpr '>'
   | '[' TypeExpr ']'
   | '{' TypeExpr '}'
   | '(' ')'
   ;
%%
