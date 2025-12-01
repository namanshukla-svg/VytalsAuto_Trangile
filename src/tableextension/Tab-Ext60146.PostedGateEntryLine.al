tableextension 60146 PostedGateEntryLine extends "Posted Gate Entry Line"
{
    fields
    {
        // Add changes to table fields here
        field(50501; "Planning No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50502; "Undo Planning No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50503; "Sales Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
    // Add changes to keys here
    }
    fieldgroups
    {
    // Add changes to field groups here
    }
    var myInt: Integer;
}
