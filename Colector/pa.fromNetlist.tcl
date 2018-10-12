
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name Colector -dir "C:/Users/Cristian/Documents/ISE/Colector/planAhead_run_1" -part xc3s500efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/Cristian/Documents/ISE/Colector/LIB_LCD_INTESC_REVC.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/Cristian/Documents/ISE/Colector} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "LIB_LCD_INTESC_REVC.ucf" [current_fileset -constrset]
add_files [list {LIB_LCD_INTESC_REVC.ucf}] -fileset [get_property constrset [current_run]]
link_design
