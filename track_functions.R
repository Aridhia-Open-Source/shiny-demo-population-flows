
add_track <- function(vis, track_radians, outer, inner, ..., interpolate = "linear-closed") {
                      ## ability to change the coordinate transformation function originally intended to
                      ## create forced perspectives but really needs something more sophistcated.
                      ## using fractional angles to give semi-circles etc worked well but could just as
                      ## easily divide track_radians
                      #, f_x = function(t) sin(t), f_y = function(t) cos(t)) {
  
  track_df <- create_track_df(track_radians, outer, inner)
  
  vis %>% layer_paths(data = track_df %>% group_by(group), ~sin(theta) * r, ~cos(theta) * r, interpolate := interpolate, ...)
  
  
}


add_circle <- function(vis, track_radians, r, ..., interpolate = "linear-open") {
  
  df <- data.frame(name = names(track_radians), theta = track_radians, r = r)
  
  vis %>% layer_paths(data = df %>% group_by(name), ~sin(theta) * r, ~cos(theta) * r, interpolate := interpolate, ...)
  
}


add_ticks <- function(vis, radians, outer, inner, ...) {
  
  df <- data.frame(theta = rep(radians, 2), r = c(rep(outer, length(radians)), rep(inner, length(radians))))
  
  vis %>% layer_paths(data = df %>% group_by(theta), ~sin(theta) * r, ~cos(theta) * r, ...)
  
}


add_links <- function(vis, name_from, name_to, pos_from, pos_to, seq_df, start_r, end_r = start_r, ..., interpolate = "basis") {
  
  link_df <- fit_links(name_from, name_to, pos_from, pos_to, seq_df, start_r, end_r)
  
  vis %>% layer_paths(data = link_df, ~sin(theta) * r, ~cos(theta) * r, interpolate := interpolate, ...)
  
}

add_ribbons <- function(vis, name_from, name_to, pos_from_start, pos_from_end, pos_to_start, pos_to_end, seq_df, start_r, end_r = start_r, ..., interpolate = "basis") {
  
  ribbon_df <- fit_ribbons(name_from, name_to, pos_from_start, pos_from_end, pos_to_start, pos_to_end, seq_df, start_r, end_r)
  
  vis %>% layer_paths(data = ribbon_df, ~sin(theta) * r, ~cos(theta) * r, interpolate := interpolate, ...)
  
}






