tableextension 60018 "SSD Posted Whse Rcpt Header" extends "Posted Whse. Receipt Header"
{
    fields
    {
        // field(62000; "SSD Dock No."; Code[20])
        // {
        //     Caption = 'Dock No.';
        //     DataClassification = CustomerContent;
        //     TableRelation = "SSD Dock".Code where("Location Code"=field("Location Code"));
        // }
        // field(62001; "SSD Slot No."; Code[20])
        // {
        //     Caption = 'Slot No.';
        //     DataClassification = CustomerContent;
        //     TableRelation = "SSD Dock Time Slots"."Slot No." where("Location Code"=field("Location Code"), "Dock No."=field("SSD Dock No."));
        // }
        // field(62002; "SSD Slot Starting Time"; Time)
        // {
        //     Caption = 'Slot Starting Time';
        //     DataClassification = CustomerContent;
        //     Editable = false;
        // }
        // field(62003; "SSD Slot Ending Time"; Time)
        // {
        //     Caption = 'Slot Ending Time';
        //     DataClassification = CustomerContent;
        //     Editable = false;
        // }
        // field(62004; "SSD Material Type";Enum "SSD Item Sub Type")
        // {
        //     Caption = 'Material Type';
        //     DataClassification = CustomerContent;
        // }
        field(62005; "SSD Status";Enum "SSD Receipt Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(62006; "SSD Source Name"; Text[100])
        {
            Caption = 'Source Name';
            Editable = false;
        }
        field(62007; "SSD Shipment Date"; Date)
        {
            Caption = 'Vendor Invoice Date';
        }
    }
}
