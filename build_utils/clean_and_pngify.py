#!/usr/bin/python3
import sys
import typer
from os import path
import os
import subprocess

def deltree(target):
    for d in os.listdir(target):
        abs_d = path.join(target, d)
        if path.isdir(abs_d):
            deltree(abs_d)
            os.rmdir(abs_d)
        else:
            if ".git" in d: continue
            os.remove(abs_d)
        
def check_root_path(root_path: str) -> bool:
    if (not path.isdir(root_path)):
        return False
    ls = os.listdir(root_path)
    if ("svg" not in ls or "png" not in ls or "build_utils" not in ls):
        return False
    return True


def clean_svg(jar_path: str, svg_path: str):
    command = ["java", "-jar", f"{jar_path}", "-d", f"{svg_path}"]
    typer.echo("Pulendo gli svg generati...")
    subprocess.run(command, stdout=subprocess.DEVNULL,
                   stderr=subprocess.DEVNULL)
    typer.echo("Pulizia finita :)")


def generate_pngs(svg_path: str, png_path: str):
    width: int = 2160
    commands = list()
    for svg_filename in os.listdir(svg_path):
        svg_filepath = path.join(svg_path, svg_filename)
        png_filename = svg_filename[:-4] + ".png"
        png_filepath = path.join(png_path, png_filename)
        commands.append(["inkscape", "-w", str(width), "--export-type", "png",
                        "-b", "white", f"{svg_filepath}", "-o", f"{png_filepath}"])

    # subprocess.run(["rm", "-rf", path.join(png_path, "*")], shell=True)
    if len(commands) == 0:
        typer.secho("Non è presente nessun file svg", err=True, fg=typer.colors.RED)
        sys.exit(-1)
    deltree(png_path)
    with typer.progressbar(commands, label="Conversione SVG->PNG") as comandi:
        for comando in comandi:
            subprocess.run(comando, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


def rename_pngs(png_path: str):
    with typer.progressbar(os.listdir(png_path), label="Riorganizzando i file png") as filelist:
        for png in filelist:
            values = png.split("!")
            if len(values) <= 1 or not png.endswith("png"):
                continue
            macro_use_case = values[0]
            macro_use_case_path = path.join(png_path, macro_use_case)
            os.makedirs(macro_use_case_path, exist_ok=True)
            use_case = values[1].split("_")[0]
            is_sequence = len(values) >= 3

            prefix = "SD" if is_sequence else "UC"
            dest_name = f"{prefix} - {use_case}.png"
            dest_path = path.join(macro_use_case_path, dest_name)
            os.rename(path.join(png_path, png), dest_path)
            # print(f"mv \"{png}\" \"{dest_path}\" ")


def main(root_path: str = typer.Argument(".", help="La cartella principale in cui sono presenti: \"svg/, png/ e build_utils/\""),
         cleanup: bool = typer.Option(
             False, "--cleanup", "-c", help="Pulisci le cartelle svg e png e basta")
         ):
    is_valid = check_root_path(root_path)
    if not is_valid:
        testo = typer.style(
            "Il percorso specificato non contiene le cartelle necessarie: ", fg=typer.colors.RED)
        testo = testo + typer.style("(svg, png, build_utils)",
                                    fg=typer.colors.WHITE, bg=typer.colors.RED)
        typer.echo(testo, err=True)
        sys.exit(-1)



    full_path = path.abspath(root_path)
    build_utils = path.join(full_path, "build_utils")
    svg = path.join(full_path, "svg")
    png = path.join(full_path, "png")

    if cleanup:
        typer.secho("Pulendo la cartella svg...")
        # subprocess.run(["rm", "-rf", path.join(svg, "*")], shell=True)
        deltree(svg)
        return
    jar_filename = [file for file in os.listdir(
        build_utils) if file.endswith(".jar")][0]
    jar_path = path.join(build_utils, jar_filename)
    clean_svg(jar_path, svg_path=svg)
    generate_pngs(svg, png)
    rename_pngs(png)


if __name__ == '__main__':
    typer.run(main)
