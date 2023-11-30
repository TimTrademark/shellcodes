import argparse
from binascii import hexlify

parser = argparse.ArgumentParser("Tool to convert string to hex little endian")
parser.add_argument("string", help="The string to convert", type=str)

def main():
    args = parser.parse_args()
    hex_num = hexlify(args.string.encode())
    print(hex_num)
    big_endian = bytearray.fromhex(str(hex_num, 'utf-8'))
    big_endian.reverse()
    little_endian = ''.join(f"{n:02X}" for n in big_endian)
    print(little_endian)

if __name__ == '__main__':
    main()