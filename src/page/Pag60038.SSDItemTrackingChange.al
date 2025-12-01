page 60038 "SSD Item Tracking Change"
{
    ApplicationArea = All;
    Caption = 'Item Tracking Change';
    PageType = Card;
    SourceTable = Item;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the item.';
                }
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                    ToolTip = 'Specifies how serial, lot or package numbers assigned to the item are tracked in the supply chain.';
                }
                field(NewItemTrackingCode; NewItemTrackingCode)
                {
                    TableRelation = "Item Tracking Code";
                    Caption = 'New Item Tracking Code';
                    ToolTip = 'Specifies the value of the New Item Tracking Code field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Update)
            {
                action(UpdateTracking)
                {
                    Caption = 'Update Tracking';
                    Image = UpdateDescription;
                    ToolTip = 'Executes the Update Tracking action.';

                    trigger OnAction()
                    var
                        ItemLedgerEntry: Record "Item Ledger Entry";
                        ItemTrackingCode: Record "Item Tracking Code";
                    begin
                        ItemLedgerEntry.SetLoadFields("Item No.", Open);
                        ItemLedgerEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.", "Package No.");
                        ItemLedgerEntry.SetRange("Item No.", Rec."No.");
                        ItemLedgerEntry.SetRange(Open, true);
                        if not ItemLedgerEntry.IsEmpty then Error('There are open Entries for this Item.');
                        ItemTrackingCode.Get(NewItemTrackingCode);
                        ItemTrackingCode.TestField("Package Specific Tracking", true);
                        Rec."Item Tracking Code":=NewItemTrackingCode;
                        Rec.Modify();
                    end;
                }
            }
        }
        area(Promoted)
        {
            actionref(UpdateTracking_Promoted; UpdateTracking)
            {
            }
        }
    }
    var NewItemTrackingCode: Code[10];
}
