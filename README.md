# Nationalize
Predict the Ethnicity of a Name

```
  _   _           _     _                           _   _              
 | \ | |   __ _  | |_  (_)   ___    _ __     __ _  | | (_)  ____   ___ 
 |  \| |  / _` | | __| | |  / _ \  | '_ \   / _` | | | | | |_  /  / _ \
 | |\  | | (_| | | |_  | | | (_) | | | | | | (_| | | | | |  / /  |  __/
 |_| \_|  \__,_|  \__| |_|  \___/  |_| |_|  \__,_| |_| |_| /___|  \___|
```

## Install

To use the Nationalize script, follow these steps:

1. Clone the repository:

    ```
    git clone https://github.com/haithamaouati/Nationalize.git
    ```

2. Change to the Nationalize directory:

    ```
    cd Nationalize
    ```
    
3. Change the file modes
    ```
    chmod +x nationalize.sh
    ```
    
5. Run the script:

    ```
    ./nationalize.sh
    ```

## Usage
Usage: `./nationalize.sh -n <NAME>`

##### Options:

`-n`, `--name`       Specify the name to analyze (required)

`-h`, `--help`    Show this help message

## Dependencies

The script requires the following dependencies:

- [figlet](http://www.figlet.org/): `pkg install figlet - y`
- [curl](https://curl.se/): `pkg install curl - y`
- [jq](https://jqlang.org/): `pkg install jq -y`
- [bc]() `pkg install bc -y`

Make sure to install these dependencies before running the script.

## Author

Made with :coffee: by **Haitham Aouati**
  - GitHub: [github.com/haithamaouati](https://github.com/haithamaouati)

## License

Nationalize is licensed under [WTFPL license](LICENSE)
