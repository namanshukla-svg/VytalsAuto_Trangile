pageextension 60008 "SSD Outward Gate Entry" extends "Outward Gate Entry"
{
    layout
    {
        modify("Vehicle No.")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Editable = false;
        }
        addlast(General)
        {
            field("SSD Planning No."; Rec."SSD Planning No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Planning No. field.', Comment = '%';

                trigger OnAssistEdit()
                var
                    WHShipHdr: Record "Warehouse Shipment Header";
                    WHShipHdr2: Record "Warehouse Shipment Header";
                    WHShipList: Page "Warehouse Ship List";
                begin
                    if Rec."Entry Type" = Rec."Entry Type"::Outward then begin
                        if Rec."SSD Planning No." = '' then begin
                            Rec."SSD Dock No.":='';
                            Rec."SSD Time Slot No.":='';
                            Rec."SSD Time Slot Starting Time":=0T;
                            Rec."SSD Time Slot Ending Time":=0T;
                            Rec."SSD Material Type":=Rec."SSD Material Type"::" ";
                        //IG_DS Rec.ResetGateEntryLines();
                        end;
                        WHShipHdr.Reset();
                        WHShipHdr.SetRange(Status, WHShipHdr.Status::Released);
                        if Page.RunModal(Page::"Warehouse Ship List", WHShipHdr) = Action::LookupOK then begin
                            Rec."SSD Planning No.":=WHShipHdr."No.";
                            Rec."SSD Dock No.":=WHShipHdr."SSD Dock No.";
                            Rec."SSD Time Slot No.":=WHShipHdr."SSD Slot No.";
                            rec."SSD Time Slot Starting Time":=WHShipHdr."SSD Slot Starting Time";
                            rec."SSD Time Slot Ending Time":=WHShipHdr."SSD Slot Ending Time";
                            WHShipHdr2.Reset();
                            WHShipHdr2.SetRange(Merged, true);
                            if WHShipHdr2.FindSet()then repeat // SkipLineCheck := true;
                                    Rec.InsertGateEntryLines(WHShipHdr2);
                                until WHShipHdr2.Next() = 0;
                        end;
                        //  SkipLineCheck := false;
                        WHShipHdr2.Reset();
                        WHShipHdr2.SetRange(Merged, true);
                        if WHShipHdr2.FindSet()then repeat WHShipHdr2.Merged:=false;
                                WHShipHdr2.Modify();
                            until WHShipHdr2.Next() = 0;
                    end;
                end;
            }
            field("SSD Dock No."; Rec."SSD Dock No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dock No. field.', Comment = '%';
            }
            field("SSD Time Slot No."; Rec."SSD Time Slot No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Slot No. field.', Comment = '%';
            }
            field("SSD Time Slot Starting Time"; Rec."SSD Time Slot Starting Time")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Slot Starting Time field.', Comment = '%';
            }
            field("SSD Time Slot Ending Time"; Rec."SSD Time Slot Ending Time")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Slot Ending Time field.', Comment = '%';
            }
            field("SSD Driver Code"; Rec."SSD Driver Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SSD Driver Code field.', Comment = '%';
            }
            field("SSD Driver Name"; Rec."SSD Driver Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SSD Driver Name field.', Comment = '%';
            }
            field("SSD Vehicle No."; Rec."SSD Vehicle No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SSD Vehicle No. field.', Comment = '%';
            }
            field("SSD Vehicle Status"; Rec."SSD Vehicle Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SSD Vehicle Status field.', Comment = '%';
            }
        }
        addfirst(FactBoxes)
        {
            part(GateInPicture; "SSD Gate In Picture")
            {
                ApplicationArea = All;
                Caption = 'Gate-In';
                SubPageLink = "Entry Type"=field("Entry Type"), "No."=field("No.");
            }
            // part(GateOutPicture; "SSD Gate Out Picture")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Gate-Out';
            //     SubPageLink = "Entry Type" = field("Entry Type"), "No." = field("No.");
            // }
            part(SourceDocumentPicture; "SSD Gate Source Document")
            {
                ApplicationArea = All;
                Caption = 'Source Document';
                SubPageLink = "Entry Type"=field("Entry Type"), "No."=field("No.");
            }
        }
    }
    actions
    {
        modify("Po&st")
        {
            Enabled = false;
            Visible = false;
        }
        addlast("P&osting")
        {
            action("SSDPost")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post';
                Image = Post;
                RunObject = Codeunit "SSD Gate Entry Post (Yes/No)";
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company book(F9).';
            }
            action(PrintLabel)
            {
                Caption = 'Vehicle Label';
                ApplicationArea = All;
                Image = Print;
                ToolTip = 'Executes the Vehicle Label action.';

                trigger OnAction()
                var
                    GateEntryHeader: Record "Gate Entry Header";
                begin
                    GateEntryHeader.SetRange("Entry Type", Rec."Entry Type");
                    GateEntryHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"SSD Gate Entry Vehicle Label", true, true, GateEntryHeader);
                end;
            }
        }
        addfirst(Navigation)
        {
            action(RegisterDriver)
            {
                Caption = 'Register Driver';
                ApplicationArea = All;
                Image = User;
                RunObject = Page "SSD Drivers";
                ToolTip = 'Executes the Register Driver action.';
            }
            action(RegisterVehicle)
            {
                Caption = 'Register Vehicle';
                ApplicationArea = All;
                Image = ExportShipment;
                RunObject = Page "SSD Vehicles";
                ToolTip = 'Executes the Register Vehicle action.';
            }
        }
        addfirst(Category_Process)
        {
            actionref(SSDPost_Promoted; SSDPost)
            {
            }
            actionref(PrintLabel_Promoted; PrintLabel)
            {
            }
            actionref(RegisterDriver_Promoted; RegisterDriver)
            {
            }
            actionref(RegisterVehicle_Promoted; RegisterVehicle)
            {
            }
        }
    }
    var SkipLineCheck: Boolean;
}
