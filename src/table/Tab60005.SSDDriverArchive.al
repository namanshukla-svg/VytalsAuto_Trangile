table 60005 "SSD Driver Archive"
{
    Caption = 'Driver Archive';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; "Archive No."; Integer)
        {
            Caption = 'Archive No.';
        }
        field(10; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(15; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(20; "Identification Type";Enum "SSD Identification Type")
        {
            Caption = 'Identification Type';
        }
        field(21; "Identification No."; Code[30])
        {
            Caption = 'Identification No.';
        }
        field(30; "Aadhar No."; Code[16])
        {
            Caption = 'Aadhar No.';
        }
        field(31; "License Type";Enum "SSD License Type")
        {
            Caption = 'License Type';
        }
        field(32; "License No."; Code[20])
        {
            Caption = 'License No.';
        }
        field(35; "Driver Experience"; Integer)
        {
            Caption = 'Driver Experience';
        }
        field(40; "Driver Company Name"; Text[100])
        {
            Caption = 'Driver Company Name';
        }
        field(92; Picture; MediaSet)
        {
            Caption = 'Picture';
        }
        field(102; "Aadhar Photo Front"; MediaSet)
        {
            Caption = 'Aadhar Photo Front';
        }
        field(103; "Aadhar Photo Back"; MediaSet)
        {
            Caption = 'Aadhar Photo Back';
        }
        field(104; "License Picture"; MediaSet)
        {
            Caption = 'License Picture';
        }
        field(105; "Company Id"; MediaSet)
        {
            Caption = 'Company Id';
        }
    }
    keys
    {
        key(PK; "Code", "Archive No.")
        {
            Clustered = true;
        }
    }
}
