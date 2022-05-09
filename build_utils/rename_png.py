#!/usr/bin/python3
import typer
from os import path
import os


def rename_pngs(png_path: str = typer.Option(default="../png", callback=not path.isdir)):
    for png in os.listdir(png_path):
        values = png.split("!")
        if len(values) <= 1 or not png.endswith("png"): continue
        macro_use_case = values[0]
        macro_use_case_path = path.join(png_path, macro_use_case)
        os.makedirs(macro_use_case_path, exist_ok=True)
        use_case = values[1].split("_")[0]
        is_sequence = len(values) >= 3
        sequence_name = ""
        if is_sequence:
            sequence_name = " " + values[3].split("_")[0]

        prefix = "SD" if is_sequence else "UC"
        dest_name = f"{prefix} - {use_case}.png"
        dest_path = path.join(macro_use_case_path, dest_name)
        os.rename(path.join(png_path, png), dest_path)
        print(f"mv \"{png}\" \"{dest_path}\" ")

if __name__ == '__main__':
    typer.run(rename_pngs)