import kdl

def update_width_in_kdl(file_path, new_width=10):
    with open(file_path, 'r') as f:
        doc = kdl.parse(f.read())


    for node in doc.nodes:
        if node.name == "focus-ring":
            print("mhm")
            if hasattr(node, 'getAll'):
                print("good")
                all_children = list(node.getAll(None))
                print(f"Found {len(all_children)} child nodes")

                for child in all_children:
                    print(f"   Child: {child.name} with args={child.args}")
                    if child.name == "width" and child.args:
                        print(f"Current width: {child.args[0]}")
                        child.args[0] = float(new_width)
                        print(f"Updated width: {new_width}")
                        break


    with open(file_path, 'w') as f:
        f.write(str(doc))


def okdoitnow(widget):
    update_width_in_kdl("/home/carlisle/.config/niri/config.kdl", 10)
    print("test")