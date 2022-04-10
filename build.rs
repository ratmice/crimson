use cfgrammar::yacc::YaccKind;
use lrlex::CTLexerBuilder;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    CTLexerBuilder::new()
        .lrpar_config(|ctp| {
            ctp.yacckind(YaccKind::Original(cfgrammar::yacc::YaccOriginalActionKind::NoAction))
                .grammar_in_src_dir("crimson.y")
                .unwrap()
        })
        .lexer_in_src_dir("crimson.l")?
        .build()?;
    Ok(())
}
