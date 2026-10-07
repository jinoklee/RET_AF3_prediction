


set auto_zoom, 0 

**fold_WT_dimer_ATP_phospho_model_0.cif" loaded as "fold_WT_dimer_ATP_phospho_model_0".**


alter **fold_WT_dimer_ATP_phospho_model_0**, resi=str(int(resi)+723)  
sort  
remove solvent  
bg_color white  
hide everything, fold_WT_dimer_ATP_phospho_model_0  

select enzA, fold_WT_dimer_ATP_phospho_model_0 and polymer and chain A       
select subB, fold_WT_dimer_ATP_phospho_model_0 and polymer and chain B       
select atpA, byres (fold_WT_dimer_ATP_phospho_model_0 and resn ATP within 6 of (enzA and resi 758))   

### --- Chain B ---
show cartoon, subB  
color cyan, subB  
select sub_loop, subB and resi 892-909  
show sticks, sub_loop  
color magenta, sub_loop  

### --- Chain A ---
show surface, enzA  
color gray80, enzA  
set transparency, 0.7, enzA            
set surface_quality, 1  
set surface_smooth_edges, 1  



### --- ATP pocket mesh  ---
create obj_pocket, enzA within 8 of atpA  
hide everything, obj_pocket  
show mesh, obj_pocket  
set mesh_width, 0.5  
color gray40, obj_pocket                # red → gray40
set surface_carve_selection, atpA, obj_pocket  
set surface_carve_cutoff, 5.0, obj_pocket  

color yellow, atpA                         
color yellow, atpA and elem C              

show sticks, atpA   
color yellow, atpA  
util.cnc atpA   


### --- SAVE  ---

orient fold_WT_dimer_ATP_phospho_model_0  
zoom fold_WT_dimer_ATP_phospho_model_0, 2   
png dimer_cartoon_surface_mesh.png, width=1200, height=900, dpi=150, ray=1   
