
raw_lines <- readLines('concat_clocks.phy')

start_chunks <- grep('^[0-9]', raw_lines)

n_tax <- strsplit(raw_lines[start_chunks[1]], ' +')[[1]][1]

s_lens <- sapply(1:length(start_chunks), function(x) as.numeric(strsplit(raw_lines[start_chunks[x]], ' +')[[1]][2]))

all_chunks <- as.matrix(raw_lines[start_chunks[1]:(start_chunks[2] - 1)])


for(i in 2:length(start_chunks)){
      if(i < length(start_chunks)){
        temp_chunk <- as.matrix(gsub('^([a-z]|[A-Z]|[0-9])+ +| $', '', raw_lines[start_chunks[i]:(start_chunks[i+1] - 1)]))
      }else{
        temp_chunk <- as.matrix(gsub('^(([a-z]|[A-Z]|[0-9])+ +)| $', '',    raw_lines[start_chunks[i]:length(raw_lines)]))
      }
      all_chunks <- cbind(all_chunks, temp_chunk)
}

processed_lines <- vector()

for(i in 2:nrow(all_chunks)){
  processed_lines[i] <- paste0(all_chunks[i, ], collapse = '')
}

processed_lines[1] <- paste(n_tax, sum(s_lens))


cat(processed_lines, file = 'concat_test.txt', sep = '\n')