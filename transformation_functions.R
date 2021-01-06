



create_radians <- function(names = c(1:22, "X", "Y"),
                           lengths = c(249250621,243199373,198022430,191154276,180915260,171115067,
                                       159138663,146364022,141213431,135534747,135006516,133851895,
                                       115169878,107349540,102531392,90354753,81195210,78077248,
                                       59128983,63025520,48129895,51304566,155270560,59373566),
                           total_gap = 0.2,
                           ind_gaps = rep(total_gap / length(names), length(names))) {
  
  stand_lengths = lengths / sum(lengths)
  
  all_lengths <- c(rbind(ind_gaps, stand_lengths))

  all_stand_lengths <- all_lengths / sum(all_lengths)
  
  all_radians <- cumsum(all_stand_lengths) * 2 * pi
  
  names(all_radians) <- c(rbind(names, names))
  
  return(all_radians)
  
}


create_track_radians <- function(radians,
                                 names = c(1:22, "X", "Y"),
                                 approx_points = 400,
                                 points_per_track = rep(ceiling(approx_points / length(names)), length(names))) {
  
  track_radians <- do.call(c, lapply(seq_along(names),
                                     function(i) {
                                       x <- c(seq(radians[2*i - 1], radians[2*i], length.out = points_per_track[i]))
                                       names(x) <- rep(names[i], length(x))
                                       x
                                     }
                                     )
  )
  
  return(track_radians)
  
}


create_track_df <- function(track_radians, outer, inner) {
  
  outer_df <- data.frame(r = outer, theta = track_radians, group = names(track_radians))
  inner_df <- data.frame(r = inner, theta = track_radians, group = names(track_radians))
  
  ## use interpolate := "linear-closed" in layer_paths to aboid the need to join up paths manually
#   joining_df <- data.frame(r = outer, theta = radians[seq_along(radians) %% 2 == 1],
#                            group = names(radians[seq_along(radians) %% 2 == 1]))
  
  track_df <- rbind(outer_df, arrange(inner_df, -theta))
  
  return(track_df)
  
}

create_seq_df <- function(names, lengths, radians) {
  
  seq_starts <- radians[seq(1, 2*length(names), 2)]
  seq_ends <- radians[seq(2, 2*length(names), 2)]
  
  data.frame(name = names, length = lengths, seq_start = seq_starts, seq_end = seq_ends)
  
}

fit_to_names <- function(names, positions,
                         seq_df) {
  
  df <- data.frame(name = names, position = positions)
  
  df %>% 
    inner_join(seq_df, by = "name") %>% 
    mutate(new_pos = seq_start + (position/length) * (seq_end - seq_start)) %>%
    select(-seq_start, -seq_end, -length)
  
}


fit_to_track <- function(values, outer, inner, min_value = min(values), max_value = max(values)) {
  
  stand <- (values - min(values)) / (max(values) - min(values))
  
  scaled <- stand * (outer - inner) + inner
  
  scaled
  
}

fit_links <- function(name_from, name_to, pos_from, pos_to, seq_df, start_r, end_r = start_r, inner_r = 0.1) {
  
  link_df <- data.frame(name_from = name_from, name_to = name_to, pos_from, pos_to)
  
  suppressWarnings(
    transformed <- link_df %>%
      inner_join(seq_df, by = c("name_from" = "name")) %>%
      inner_join(seq_df, by = c("name_to" = "name")) %>%
      mutate(new_pos_from = seq_start.x + (pos_from / length.x) * (seq_end.x - seq_start.x),
             new_pos_to = seq_start.y + (pos_to / length.y) * (seq_end.y - seq_start.y)) %>%
      select(name_from, name_to, new_pos_from, new_pos_to) %>%
      group_by(link = row.names(.)) %>%
      do(
        data.frame(
          name_from = .$name_from,
          name_to = .$name_to,
          theta = c(.$new_pos_from,
                    ((.$new_pos_from + .$new_pos_to) %% (2*pi)) / 2,
                    .$new_pos_to)
        )
      )
    
    
  )
  
  transformed$r <- c(start_r, inner_r, end_r)
  transformed <- mutate(transformed, interchrom = ifelse(name_to == name_from, "No", "Yes"))
  
  transformed
  
}


fit_ribbons <- function(name_from, name_to, pos_from_start, pos_from_end, pos_to_start, pos_to_end, seq_df, start_r, end_r = start_r, inner_r = 0.1) {
  
  ribbon_df <- data.frame(name_from = name_from, name_to = name_to, pos_from_start, pos_from_end, pos_to_start, pos_to_end)
  
  t <- c(0, 0.02, 0.25, 0.5, 0.75, 0.98, 1)
  
  suppressWarnings(
  transformed <- ribbon_df %>%
    inner_join(seq_df, by = c("name_from" = "name")) %>%
    inner_join(seq_df, by = c("name_to" = "name")) %>%
    mutate(new_pos_from_start = seq_start.x + (pos_from_start / length.x) * (seq_end.x - seq_start.x),
           new_pos_from_end = seq_start.x + (pos_from_end / length.x) * (seq_end.x - seq_start.x),
           new_pos_to_start = seq_start.y + (pos_to_start / length.y) * (seq_end.y - seq_start.y),
           new_pos_to_end = seq_start.y + (pos_to_end / length.y) * (seq_end.y - seq_start.y)) %>%
    select(name_from, name_to, new_pos_from_start, new_pos_from_end, new_pos_to_start, new_pos_to_end) %>%
    group_by(link = row.names(.)) %>%
    do(
      data.frame(name_from = .$name_from,
                 name_to = .$name_to,
                 theta = c((.$new_pos_from_start * (1 - t) + .$new_pos_from_end * t),
                           #seq(.$new_pos_from_start, .$new_pos_from_end, length.out = 10),
                           mean(c(mean(c(.$new_pos_from_end, .$new_pos_from_start)),
                                mean(c(.$new_pos_to_end, .$new_pos_to_start)))) +
                                ifelse(abs(mean(c(.$new_pos_from_end, .$new_pos_from_start)) - mean(c(.$new_pos_to_end, .$new_pos_to_start))) > pi,
                                       pi, 0),
                           (.$new_pos_to_start * (1 - t) + .$new_pos_to_end * t),
                           #seq(.$new_pos_to_start, .$new_pos_to_end, length.out = 10),
                           mean(c(mean(c(.$new_pos_from_end, .$new_pos_from_start)),
                                mean(c(.$new_pos_to_end, .$new_pos_to_start)))) +
                             ifelse(abs(mean(c(.$new_pos_from_end, .$new_pos_from_start)) - mean(c(.$new_pos_to_end, .$new_pos_to_start))) > pi,
                                    pi, 0),
                           .$new_pos_from_start
                 ),
                 r = c(rep(start_r, length(t)),
                       inner_r,
                       rep(end_r, length(t)),
                       inner_r,
                       start_r
                 )
      )
    )
  )
  
  transformed <- mutate(transformed, interchrom = ifelse(name_to == name_from, "No", "Yes"))
  
  transformed
  
}



