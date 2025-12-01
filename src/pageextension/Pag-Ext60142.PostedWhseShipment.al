pageextension 60142 PostedWhseShipment extends "Posted Whse. Shipment"
{
    actions
    {
        // Add changes to page actions here
        addafter("&Print")
        {
            action("Print Automation")
            {
                ApplicationArea = All;
                Caption = 'Print Automation';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Print;
                ToolTip = 'Executes the Print Automation action.';

                trigger OnAction()
                var
                    WhseShptHdr: Record "Posted Whse. Shipment Header"; //Warehouse Shipment Header";
                begin
                    WhseShptHdr.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"SSD Dispatch Slip Automation P", true, false, WhseShptHdr);
                end;
            }
        }
    }
    var myInt: Integer;
}
