# oa_risk_table.R

library(dplyr)
library(kableExtra)

# module %>% 
#   select(Module,Code,"Year/Semester"=`YR-SM`) %>% 
#   inner_join(module_topics) %>% 
#   group_by(Module) %>% 
#   kable(longtable =T,booktabs=TRUE) %>%
#   kable_styling(latex_options =c("scale_down","repeat_header")) %>%
#   column_spec(1, bold = T, color = "red", width = "15em") %>%
#   column_spec(2:3, width = "7em") %>%
#   column_spec(4, width = "19em") %>% 
#   collapse_rows(columns = 1:2, latex_hline = "major", valign = "top")

oa_risk %>% 
  inner_join(oa_risk_mit, by="Id") %>% 
  group_by(Title) %>% 
  kable(longtable =T,booktabs=TRUE) %>%
  kable_styling(latex_options =c("scale_down","repeat_header")) %>%
  column_spec(2, bold = T, color = "red", width = "15em") %>%
  collapse_rows(columns = 1:2, latex_hline = "major", valign = "top")

  
