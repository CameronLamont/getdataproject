
# one-off code to assist in generation of codebook
# library(knitr)
# kable(names(ds), format="markdown",col.names=c("column name"))
# kable(names(output), format="markdown",col.names=c("column name"))
write(kable(names(ds), format="markdown",col.names=c("column name")),
      "./ds_names_kable.txt")
write(kable(names(output), format="markdown",col.names=c("column name")),
      "./output_names_kable.txt")

write(names(ds),"./ds_names.txt")
write(names(output),"./output_names.txt")
