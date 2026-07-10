pageextension 60026 "SSD Posted Purch Receipts" extends "Posted Purchase Receipt"
{
    actions
    {
        addlast(processing)
        {
            action(Print)
            {
                ApplicationArea = All;
                Caption = 'Print Labels';
                Image = Print;
                ToolTip = 'Executes the Print Labels action.';

                trigger OnAction()
                var
                    PurchReceiptHeader: Record "Purch. Rcpt. Header";
                begin
                    PurchReceiptHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"SSD Posted Receipt Labels", true, true, PurchReceiptHeader);
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref(Print_Promoted; Print)
            {
            }
            actionref(Inward_Label_Promoted; "Inward Label")
            {
            }
        }
        addafter(Print)
        {
            action("Inward Label")
            {
                ApplicationArea = All;
                Caption = 'Inward Label';
                Image = PrintReport;

                trigger OnAction()
                var
                    // ItemLedgerEntry: Record "Item Ledger Entry";
                    ItemledgerEntry: Record "Item Ledger Entry";
                begin
                    ItemledgerEntry.Reset();
                    ItemledgerEntry.SetRange("Document No.", Rec."No.");
                    if ItemledgerEntry.FindFirst() then
                        Report.RunModal(Report::"Inward Label", true, false, ItemledgerEntry)
                end;
            }
        }

    }
}
