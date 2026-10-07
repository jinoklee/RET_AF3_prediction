# ICD dimer scene: chain B = cyan cartoon, chain A = gray transparent surface, ATP pocket = mesh
#
# Usage in PyMOL (the structure must be loaded under the name "mol"):
#   load C:/Users/PC/Documents/study/50.RET/1.study/ICD/AF3/WT/WT_dimer_ATP_phospho/fold_WT_dimer_ATP_phospho_model_0.cif, mol
#   @C:/Users/PC/Documents/study/50.RET/1.study/ICD/Script/icd_dimer_ret_analysis.pml
#
# If the structure is already loaded under another name, rename it first:
#   set_name fold_WT_dimer_ATP_phospho_model_0, mol
#
# NOTE 1: run this script only ONCE per loaded structure (the residue renumbering below adds +723 each time).
#         To run it again: delete all, load the CIF as mol again, then run the script.
# NOTE 2: never put a "# comment" after a command on the same line (PyMOL passes it as arguments).
# NOTE 3: the PNG is written to PyMOL's current folder (check it with: pwd, change it with: cd C:/some/folder).

# ---------- Scene setup ----------
# do not auto-zoom to newly created objects (prevents cut-off views)
set auto_zoom, 0
# renumber residues so the kinase domain uses full-length RET numbering (+723)
alter mol, resi=str(int(resi)+723)
sort
# remove water/solvent molecules
remove solvent
# white background
bg_color white
# start from an empty display, then show only what we want
hide everything, mol
# no depth fading and no fog, so far parts of the molecule stay visible
set depth_cue, 0
set ray_trace_fog, 0

# ---------- Selections ----------
# chain A (enzyme side), chain B (substrate side)
select enzA, mol and polymer and chain A
select subB, mol and polymer and chain B
# the ATP molecule bound near catalytic Lys758 of chain A
select atpA, byres (mol and resn ATP within 6 of (enzA and resi 758))

# ---------- Chain B: cyan cartoon with the substrate loop as sticks ----------
show cartoon, subB
color cyan, subB
# substrate loop (residues 892-909)
select sub_loop, subB and resi 892-909
show sticks, sub_loop
color magenta, sub_loop

# ---------- Chain A: gray transparent surface ----------
show surface, enzA
color gray80, enzA
# semi-transparent surface (0 = opaque, 1 = invisible)
set transparency, 0.7, enzA
# make the transparency visible in ray-traced PNGs
set transparency_mode, 1
# surface mesh quality (1 = good but slow, -2 = fast preview)
set surface_quality, 1
set surface_smooth_edges, 1

# ---------- ATP pocket: gray mesh ----------
# copy of chain A residues within 8 A of ATP
create obj_pocket, enzA within 8 of atpA
hide everything, obj_pocket
show mesh, obj_pocket
set mesh_width, 0.5
color gray40, obj_pocket
# keep only the part of the pocket mesh that lies near ATP
set surface_carve_selection, atpA, obj_pocket
set surface_carve_cutoff, 5.0, obj_pocket

# ---------- ATP: sticks, yellow carbons, N/O/P in element colors ----------
show sticks, atpA
color yellow, atpA
util.cnc atpA

# ---------- View and save ----------
orient mol
zoom mol, 2
png dimer_cartoon_surface_mesh.png, width=1200, height=900, dpi=150, ray=1
