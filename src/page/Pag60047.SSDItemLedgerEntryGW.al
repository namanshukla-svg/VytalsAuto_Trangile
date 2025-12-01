page 60047 "SSD Item Ledger Entry GW"
{
    ApplicationArea = All;
    Caption = 'Item Ledger Entry GW';
    PageType = List;
    SourceTable = "Item Ledger Entry";
    UsageCategory = History;
    DeleteAllowed = false;
    InsertAllowed = false;
    Permissions = tabledata "Item Ledger Entry"=rm;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the document number on the entry. The document is the voucher that the entry was based on, for example, a receipt.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the entry''s posting date.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the number of the item in the entry.';
                    Editable = false;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies a lot number if the posted item carries such a number.';
                    Editable = false;
                }
                field("Package No."; Rec."Package No.")
                {
                    ToolTip = 'Specifies a package number if the posted item carries such a number.';
                    Editable = false;
                }
                field("SSD Gross Weight"; Rec."SSD Gross Weight")
                {
                    ToolTip = 'Specifies the value of the Gross Weight field.', Comment = '%';
                    Editable = true;
                }
            }
        }
    }
}
