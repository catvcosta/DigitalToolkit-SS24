# 3. Install and load the packages: tidyverse, knitr, MASS, and psych
# 4. Write a code that prints a long text (~30 words) and save it to a variable.
# 5. Upload your code to ILIAS.

install.packages("tidyverse")
library(tidyverse)

install.packages("knitr")
library(knitr)

install.packages("MASS")
library(MASS)

install.packages("psych")
library(psych)

longtext <- "Tomei o comboio na estação de Castanheira, depois que o Calhau deixou de me abraçar. 
Foi ele que me trouxe no carro de bois de D. Estefânia, em cuja casa, como se sabe, me talharam o destino"
print(longtext)
