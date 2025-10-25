import kdl
import os

def update_focus_ring_color_in_kdl(file_path, new_color="#0f4c5c"):
    with open(file_path, 'r') as f:
        doc = kdl.parse(f.read())


    for node in doc.nodes:
        if node.name == "focus-ring":
            if hasattr(node, 'getAll'):
                all_children = list(node.getAll(None))
                print(f"Found {len(all_children)} child nodes")

                for child in all_children:
                    print(f"   Child: {child.name} with args={child.args}")
                    if child.name == "active-color" and child.args:
                        print(f"Current color: {child.args[0]}")
                        child.args[0] = (new_color)
                        print(f"Updated color: {new_color}")
                        break


    with open(file_path, 'w') as f:
        f.write(str(doc))


def set_focus_ring_color_daisies(widget, color_value="#0f4c5c"):
    width_value = color_value if color_value is not None else "#0f4c5c"
    update_focus_ring_color_in_kdl("/home/carlisle/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout/daisies_layout_part_2.kdl", width_value)
    os.system("cat ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout/daisies_layout_part_1.kdl ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout/daisies_layout_part_2.kdl ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout/daisies_layout_part_3.kdl > ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout_final.kdl")
    os.system("cat ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/daisies_the_rest_lol.kdl ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout_final.kdl > ~/.config/niri/config.kdl")

def set_focus_ring_color_minimal(widget, color_value="#0f4c5c"):
    width_value = color_value if color_value is not None else "#0f4c5c"
    update_focus_ring_color_in_kdl("/home/carlisle/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout/minimal_layout_part_2.kdl", width_value)
    os.system("cat ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout/minimal_layout_part_1.kdl ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout/minimal_layout_part_2.kdl ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout/minimal_layout_part_3.kdl > ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout_final.kdl")
    os.system("cat ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/minimal_the_rest_lol.kdl ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout_final.kdl > ~/.config/niri/config.kdl")

def set_focus_ring_color_magic(widget, color_value="#0f4c5c"):
    width_value = color_value if color_value is not None else "#0f4c5c"
    update_focus_ring_color_in_kdl("/home/carlisle/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout/magic_layout_part_2.kdl", width_value)
    os.system("cat ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout/magic_layout_part_1.kdl ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout/magic_layout_part_2.kdl ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout/magic_layout_part_3.kdl > ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout_final.kdl")
    os.system("cat ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/magic_the_rest_lol.kdl ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout_final.kdl > ~/.config/niri/config.kdl")

def set_focus_ring_color_fall(widget, color_value="#0f4c5c"):
    width_value = color_value if color_value is not None else "#0f4c5c"
    update_focus_ring_color_in_kdl("/home/carlisle/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout/fall_layout_part_2.kdl", width_value)
    os.system("cat ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout/fall_layout_part_1.kdl ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout/fall_layout_part_2.kdl ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout/fall_layout_part_3.kdl > ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout_final.kdl")
    os.system("cat ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/fall_the_rest_lol.kdl ~/TacOS/TacOS/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/niri_config_file_sections/layout_final.kdl > ~/.config/niri/config.kdl")
