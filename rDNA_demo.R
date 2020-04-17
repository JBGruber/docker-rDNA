# Code from https://github.com/leifeld/dna/releases/download/v2.0-beta.20/dna-manual.pdf for test run of rDNA

#
library("rDNA")

#
set.seed(12345)

#
dna_downloadJar()

#
dna_init()

# do not run in headless environment like docker
#dna_gui(dna_sample())

#
conn <- dna_connection(dna_sample())

#
nw <- dna_network(conn)

#
# First attach the statnet package
library("statnet")

# Then simply use gplot
gplot(nw)

#
at <- dna_attributes(conn)

#
congruence <- dna_network(conn, 
                          networkType = "onemode", 
                          statementType = "DNA Statement", 
                          variable1 = "organization", 
                          variable2 = "concept", 
                          qualifier = "agreement", 
                          qualifierAggregation = "congruence", 
                          duplicates = "document")

#
nw <- network(congruence)
plot(nw, 
     edge.lwd = congruence^2, 
     displaylabels = TRUE, 
     label.cex = 0.5, 
     usearrows = FALSE, 
     edge.col = "gray"
)

#
dna_plotCentrality(conn,
                   of = "concept",
                   fontSize = 10)

#
dna_plotCentrality(conn,
                   of = "organization",
                   fontSize = 10,
                   excludeValues = list("concept" = 
                                          "There should be legislation to regulate emissions."),
                   invertValues = TRUE)

#
congruence <- 
  dna_network(conn,
              networkType = "onemode", 
              statementType = "DNA Statement", 
              variable1 = "organization", 
              variable2 = "concept", 
              qualifier = "agreement", 
              qualifierAggregation = "congruence", 
              duplicates = "document", 
              excludeValues = list("concept" = 
                                     "There should be legislation to regulate emissions."))
                                     
nw <- network(congruence)
plot(nw, 
     edge.lwd = congruence^2, 
     displaylabels = TRUE, 
     label.cex = 0.5, 
     usearrows = FALSE, 
     edge.col = "gray"
)

#
at <- dna_attributes(conn, 
                     statementType = "DNA Statement", 
                     variable = "person")
at

#
plot(nw, 
     edge.lwd = congruence^2, 
     displaylabels = TRUE, 
     label.cex = 0.5, 
     usearrows = FALSE, 
     edge.col = "gray", 
     vertex.col = at$color, 
     vertex.cex = at$frequency
)

#
affil <- dna_network(conn, 
                     networkType = "twomode", 
                     statementType = "DNA Statement", 
                     variable1 = "organization", 
                     variable2 = "concept", 
                     qualifier = "agreement", 
                     qualifierAggregation = "combine", 
                     duplicates = "document",
                     verbose = FALSE)

#
nw <- network(affil, bipartite = TRUE)
colors <- as.character(t(affil))
colors[colors == "3"] <- "deepskyblue"
colors[colors == "2"] <- "indianred"
colors[colors == "1"] <- "#31a354"
colors <- colors[colors != "0"]
set.edge.attribute(nw, "color", colors)
plot(nw, 
     edge.col = get.edge.attribute(nw, "color"), 
     vertex.col = c(rep("white", nrow(affil)), 
                    rep("black", ncol(affil))), 
     displaylabels = TRUE, 
     label.cex = 0.5
)

#
clust.l <- dna_cluster(conn)




