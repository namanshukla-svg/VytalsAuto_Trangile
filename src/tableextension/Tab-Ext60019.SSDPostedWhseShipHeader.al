tableextension 60019 "SSD Posted Whse Ship Header" extends "Posted Whse. Shipment Header"
{
    fields
    {
        // field(60000; "SSD Dock No."; Code[20])
        // {
        //     Caption = 'Dock No.';
        //     DataClassification = CustomerContent;
        //     TableRelation = "SSD Dock".Code where("Location Code"=field("Location Code"));
        // }
        // field(60001; "SSD Slot No."; Code[20])
        // {
        //     Caption = 'Slot No.';
        //     DataClassification = CustomerContent;
        //     TableRelation = "SSD Dock Time Slots"."Slot No." where("Location Code"=field("Location Code"), "Dock No."=field("SSD Dock No."));
        // }
        // field(60002; "SSD Slot Starting Time"; Time)
        // {
        //     Caption = 'Slot Starting Time';
        //     DataClassification = CustomerContent;
        //     Editable = false;
        // }
        // field(60003; "SSD Slot Ending Time"; Time)
        // {
        //     Caption = 'Slot Ending Time';
        //     DataClassification = CustomerContent;
        //     Editable = false;
        // }
        // field(60004; "SSD Material Type";Enum "SSD Item Sub Type")
        // {
        //     Caption = 'Material Type';
        //     DataClassification = CustomerContent;
        // }
        // field(60005; "SSD Combined With"; Code[20])
        // {
        //     Caption = 'Combined With';
        //     DataClassification = CustomerContent;
        //     TableRelation = "Warehouse Shipment Header" where(Status=const(Released));//, "SSD Combined With"=const(''));
        // }
        field(60006; "SSD Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(60007; "SSD Mode of Transport"; Text[20])
        {
            Caption = 'Mode of Transport';
            DataClassification = CustomerContent;
        }
        field(60008; "SSD Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
            DataClassification = CustomerContent;
        }
    }
}
