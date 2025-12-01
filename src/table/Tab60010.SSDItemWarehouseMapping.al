table 60010 "SSD Item Warehouse Mapping"
{
    Caption = 'Item Warehouse Mapping';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(2; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("SSD Automated Plant"=const(true));
        }
        field(60010; "SSD Zone Preference 1"; Code[20])
        {
            Caption = 'Zone Preference 1';
            DataClassification = CustomerContent;
            TableRelation = "SSD ASRS Zone".Code where("Location Code"=field("Location Code"));

            trigger OnValidate()
            begin
                if SSDASRSZone.Get("Location Code", "SSD Zone Preference 1")then "SSD Zone Preference 1 Name":=SSDASRSZone.Description
                else
                    "SSD Zone Preference 1 Name":='';
            end;
        }
        field(60011; "SSD Zone Preference 1 Name"; Text[100])
        {
            Caption = 'Zone Preference 1 Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60020; "SSD Zone Preference 2"; Code[20])
        {
            Caption = 'Zone Preference 2';
            DataClassification = CustomerContent;
            TableRelation = "SSD ASRS Zone".Code where("Location Code"=field("Location Code"));

            trigger OnValidate()
            begin
                if SSDASRSZone.Get("Location Code", "SSD Zone Preference 2")then "SSD Zone Preference 2 Name":=SSDASRSZone.Description
                else
                    "SSD Zone Preference 2 Name":='';
            end;
        }
        field(60021; "SSD Zone Preference 2 Name"; Text[100])
        {
            Caption = 'Zone Preference 2 Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60030; "SSD Reject Zone"; Code[20])
        {
            Caption = 'Hard Quarantine Zone';
            DataClassification = CustomerContent;
            TableRelation = "SSD ASRS Zone".Code where("Location Code"=field("Location Code"));

            trigger OnValidate()
            begin
                if SSDASRSZone.Get("Location Code", "SSD Reject Zone")then "SSD Reject Zone Name":=SSDASRSZone.Description
                else
                    "SSD Reject Zone Name":='';
            end;
        }
        field(60031; "SSD Reject Zone Name"; Text[100])
        {
            Caption = 'Hard Quarantine Zone Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Item No.", "Location Code")
        {
            Clustered = true;
        }
    }
    var SSDASRSZone: Record "SSD ASRS Zone";
}
