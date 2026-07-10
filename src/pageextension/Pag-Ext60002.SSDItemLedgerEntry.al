pageextension 60002 "SSD Item Ledger Entry" extends "Item Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("SSD Gross Weight"; Rec."SSD Gross Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gross Weight field.', Comment = '%';
            }
            field("SSD Entry Synced"; Rec."SSD Entry Synced")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Entry Synced field.', Comment = '%';
            }
        }
    }
    actions
    {
        addafter("Reservation Entries")
        {
            action(Sync)
            {
                ApplicationArea = All;
                Caption = 'Sync with WMS';
                Image = OutlookSyncFields;
                ToolTip = 'Executes the Sync with WMS action.';

                trigger OnAction()
                var
                    SSDReservationManagement: Codeunit "SSD Reservation Management";
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.FindSet() then
                        repeat
                            SSDReservationManagement.SyncitemLedgerEntry2(Rec);
                        until Rec.Next() = 0;
                    Clear(Rec);
                    CurrPage.Update(false);
                end;
            }
            action(RemoveSync)
            {
                ApplicationArea = All;
                Caption = 'Remove Sync with WMS';
                Image = RemoveContacts;
                ToolTip = 'Executes the Remove Sync with WMS action.';

                trigger OnAction()
                var
                    SSDUpdateSyncEntries: Codeunit "SSD Update Sync Entries";
                begin
                    SSDUpdateSyncEntries.RemoveWMSSync(Rec);
                end;
            }
            action("BARCODE LEBEL RECEIPT3x2-Post")
            {
                ApplicationArea = All;
                Caption = 'BARCODE LEBEL RECEIPT3x2-Post';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Report;
                RunObject = report "SSD Barcode Label Receipt3x2";
                ToolTip = 'Executes the BARCODE LEBEL RECEIPT3x2-Post action.';
            }
        }
        addfirst(processing)
        {
            action("Inward Label")
            {
                ApplicationArea = All;
                Caption = 'Inward Label';
                Image = PrintReport;
                // Visible = false;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    // ItemLedgerEntry: Record "Item Ledger Entry";
                    ItemledgerEntry: Record "Item Ledger Entry";
                begin
                    ItemledgerEntry.Reset();
                    ItemledgerEntry.SetRange("Document No.", Rec."Document No.");
                    if ItemledgerEntry.FindFirst() then
                        Report.RunModal(Report::"Inward Label", true, false, ItemledgerEntry)
                end;
            }
        }

    }
    procedure GetFilter(var ItemLedgerEntry: Record "Item Ledger Entry")
    begin
    end;
}
