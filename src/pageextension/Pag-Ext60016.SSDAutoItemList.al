pageextension 60016 "SSD Auto Item List" extends "Item List"
{
    layout
    {
        addlast(Control1)
        {
            // Atul::01122025
            // field("SSD Pallet Type"; Rec."SSD Pallet Type")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Pallet Type field.', Comment = '%';
            // }
            // Atul::01122025
            field("SSD Item SubType"; Rec."SSD Item SubType")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item SubType field.', Comment = '%';
            }
            // Atul::01122025
            // field("SSD Consumption Station"; Rec."SSD Consumption Station")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Consumption Station field.', Comment = '%';
            // }
            // field("SSD Storage Type"; Rec."SSD Storage Type")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Storage Type field.', Comment = '%';
            // }
            // Atul::01122025
            field("SSD Low Flash"; Rec."SSD Low Flash")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Low Flash field.', Comment = '%';
            }
            field("SSD Packing"; Rec."SSD Packing")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Packing field.', Comment = '%';
            }
        }
    }
}
