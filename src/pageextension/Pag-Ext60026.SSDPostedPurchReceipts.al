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
        }
    }
}
