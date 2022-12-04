
FRED_API_key <- "f3331994991ae94491e451a245b4ee61"

data_out_loc <- "/Users/grodriguezrondon/Dropbox/Res/papers/multi_msm_busi_cyc_jbcr_si/multi_msm_busi_cyc_jbcr_si/data/"

# ----- FRED API Data ----- 
fredr::fredr_set_key(FRED_API_key)

start_date  <- "1919-01-01"
end_date    <- "2022-09-01"

# Get FRED PIP Data
series_list <-  rbind(c("INDPRO",        "US IPI - SA"),
                      c("CANPROINDMISMEI", "CA IPI - SA"),
                      c("GBRPROINDMISMEI", "UK IPI - SA"),
                      c("DEUPROINDMISMEI", "GR IPI - SA"),
                      c("IR3TIB01USM156N", "US 3M IR - NSA"),
                      c("IR3TIB01CAM156N", "CA 3M IR - NSA"),
                      c("IR3TIB01GBM156N", "UK 3M IR - NSA"),
                      c("IR3TIB01DEM156N", "GR 3M IR - NSA"),
                      c("LRHUTTTTUSM156S", "US HUR - SA"),
                      c("LRHUTTTTCAM156S", "CA HUR - SA"),
                      c("LRHUTTTTGBM156S", "UK HUR - SA"),
                      c("LRHUTTTTDEM156S", "GR HUR - SA"),
                      c("SPASTT01USM657N", "US TSP - NSA"),
                      c("SPASTT01CAM657N", "CA TSP - NSA"),
                      c("SPASTT01GBM657N", "UK TSP - NSA"),
                      c("SPASTT01DEM657N", "GR TSP - NSA"))


FREDdata <- data.frame(Date = seq(from = as.Date(start_date), to = as.Date(end_date), by = "1 month"))
for (i in 1:nrow(series_list)){
  dat1 <- fredr::fredr(series_id = series_list[i,1],
                       observation_start = as.Date(start_date),
                       observation_end = as.Date(end_date))
  dat1_frame <- data.frame(dat1$date,dat1$value)
  colnames(dat1_frame) <-c("Date", series_list[i,2])
  FREDdata <- merge(FREDdata, dat1_frame, by = "Date", all = TRUE)
}


IPdata <- FREDdata[,c(1,2:5)]
IRdata <- FREDdata[,c(1,6:9)]
URdata <- FREDdata[,c(1,10:13)] 
SPdata <- FREDdata[,c(1,14:17)] 

IPdata <- IPdata[complete.cases(IPdata),]
rownames(IPdata) <- NULL

IRdata <- IRdata[complete.cases(IRdata),]
rownames(IRdata) <- NULL

URdata <- URdata[complete.cases(URdata),]
rownames(URdata) <- NULL

SPdata <- SPdata[complete.cases(SPdata),]
rownames(SPdata) <- NULL


# save files
write.csv(FREDdata, file = paste0(data_out_loc,"all_data.csv"), row.names = FALSE)
write.csv(IPdata,   file = paste0(data_out_loc,"IndustrialProd_data.csv"), row.names = FALSE)
write.csv(IRdata,   file = paste0(data_out_loc,"InterestRate_data.csv"), row.names = FALSE)
write.csv(URdata,   file = paste0(data_out_loc,"Unemployment_data.csv"), row.names = FALSE)
write.csv(SPdata,   file = paste0(data_out_loc,"SharePrice_data.csv"), row.names = FALSE)








