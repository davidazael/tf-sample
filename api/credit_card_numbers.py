import re

def credit_card_num_validation(num: str) -> bool:
    ''' 
    Validates if number is valid credit card number.

    Validation Constratins:
        ► It must start with a 4,5, or 6
            ^[456]
        ► It must contain exactly 16 digits.
            \d{16}
        ► It must only consist of digits (0-9).
            \d == [0-9]
        ► It may have digits in groups of 4, separated by one hyphen "-".
            Optional Character 
        ► It must NOT use any other separator like ' ' , '_', etc.
            Regex won't match if string contains anything other than '-'
        ► It must NOT have  or more consecutive repeated digits. 
    '''
    if re.match(r"^[456]([\d]{15}|[\d]{3}(-[\d]{4}){3})$", num) and not re.search(r'(\d)\1{3}',num.replace("-", "")):
        return True
    return False

def executer():
    for _ in range(int(input().strip(()))):
        credit_card_num = input().strip()
        print("Valid" if credit_card_num_validation(credit_card_num) else "Invalid") 

def main():
    executer()

if __name__ == '__main__':
    main()
