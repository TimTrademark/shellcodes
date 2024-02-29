# Shellcodes

## Intro

This is a repository containing assembly implementations of useful actions for ethical hackers / pentesters.

| Shellcode                    | Status |
| ---------------------------- | ------ |
| Reverse shell linux          | ✅     |
| Execute shell linux          | ✅     |
| HTTP download file & execute | 🚧     |

## Convert assembly to shellcode

To convert assembly to shellcode you can use the following snippet on linux (assumes nasm is installed):

```
# make sure to replace file with your filename

nasm file.asm

hexdump -v -e '"\\""x" 1/1 "%02x" ""' file
```

Additionally, .hex files with pre-compiled hex shellcode are available.
