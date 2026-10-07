# ECD dimer scene: chain-colored cartoon + semi-transparent surface (pLDDT > 50)
#
# Usage in PyMOL (the structure must be loaded under the name "mol"):
#   load C:/Users/PC/Documents/study/50.RET/1.study/ECD/AF3/WT/WT_dimer_GDNF_GFRa1/fold_WT_dimer_GDNF_GFRa1_model_0.cif, mol
#   @C:/Users/PC/Documents/study/50.RET/1.study/ECD/Script/ecd_dimer_surface.pml
#
# If the structure is already loaded under another name, rename it first:
#   set_name fold_WT_dimer_GDNF_GFRa1_model_0, mol
#
# NOTE: never put a "# comment" after a command on the same line (PyMOL passes it as arguments).

# ---------- Scene setup ----------
# white background, opaque when ray-traced
bg_color white
set ray_opaque_background, 1
# nicer helix rendering
set cartoon_fancy_helices, 1
# do not auto-zoom to newly created objects (prevents cut-off views)
set auto_zoom, 0
# start clean if the script is run a second time
delete surf_obj
delete core_sel
# remove water/solvent molecules
remove solvent
# show everything as cartoon only
show_as cartoon, mol

# ---------- Color settings ----------
# custom colors: RET = white, GFRa = mint, ligand = coral
set_color ret_white, [1.000, 1.000, 1.000]
set_color gfra_mint, [0.063, 0.725, 0.506]
set_color ligand_coral, [0.957, 0.247, 0.365]
# chain A/B = RET
color ret_white, mol and (chain A or chain B)
# chain C/D = GFRa co-receptor
color gfra_mint, mol and (chain C or chain D)
# chain E/F = ligand
color ligand_coral, mol and (chain E or chain F)

# ---------- Surface (confident residues only) ----------
# well-predicted polymer residues (pLDDT is stored in the b-factor column)
select core_sel, mol and polymer and b > 50
# copy them into a separate object so only this part gets a surface
create surf_obj, core_sel
# surface takes atom colors at creation time, so color the copy as well
color ret_white, surf_obj and (chain A or chain B)
color gfra_mint, surf_obj and (chain C or chain D)
color ligand_coral, surf_obj and (chain E or chain F)
show_as surface, surf_obj
# semi-transparent surface (0 = opaque, 1 = invisible)
set transparency, 0.40, surf_obj
# make the transparency visible in ray-traced PNGs
set transparency_mode, 1
set surface_smooth_edges, 1
# surface mesh quality (1 = good but slow, -2 = fast preview)
set surface_quality, 1
# keep the cartoon on the original object (low-confidence loops stay as ribbons)
show cartoon, mol
set cartoon_transparency, 0.0, mol

# ---------- Cleanup and view ----------
deselect
delete core_sel
orient mol
zoom mol, 5
