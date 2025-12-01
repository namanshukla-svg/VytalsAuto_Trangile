pageextension 60144 PostedOutGateEntry extends "Posted Outward Gate SubForm"
{
    layout
    {
        // Add changes to page layout here
        addafter("Challan Date")
        {
            field("Sales Invoice No."; Rec."Sales Invoice No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Planning No."; Rec."Planning No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
    actions
    {
        // Add changes to page actions here
        addfirst(Processing)
        {
            action(Undo)
            {
                Image = Undo;
                ApplicationArea = All;
                Caption = 'Undo';

                trigger OnAction()
                var
                    DockLines: Record "SSD Dock Lines";
                begin
                    Rec.TestField("Planning No.");
                    if not Confirm('Do you want to undo %1?', false, Rec."Planning No.")then exit;
                    DockLines.Reset();
                    DockLines.SetRange("Entry Type", DockLines."Entry Type"::Outward);
                    DockLines.SetRange("Gate Entry No.", Rec."Gate Entry No.");
                    DockLines.SetRange("Planning No.", Rec."Planning No.");
                    if DockLines.FindFirst()then if(DockLines.Status = DockLines.Status::Completed) or (DockLines.Status = DockLines.Status::"Dock Out")then Error('Planning already fulfilled')
                        else
                        begin
                            DockLines."Gate Entry No.":='';
                            DockLines."Gate Entry Date":=0D;
                            DockLines."Driver Code":='';
                            DockLines."Driver Name":='';
                            DockLines."Vehicle No.":='';
                            DockLines.Status:=DockLines.Status::Planned;
                            DockLines.Modify(true);
                            Rec.Validate("Undo Planning No.", Rec."Planning No.");
                            Rec.Validate("Planning No.", '');
                            Rec.Modify(true);
                            Message('Undo completed for %1.', Rec."Undo Planning No.");
                        end;
                    CurrPage.Update();
                end;
            }
        }
    }
}
