page 60042 "SSD Process Pick Wave"
{
    ApplicationArea = All;
    Caption = 'Process Pick Wave';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            field(DockCode; DockCode)
            {
                Caption = 'DockCode';
                Editable = false;
                ToolTip = 'Specifies the value of the DockCode field.';
            }
            field(PickDate; PickDate)
            {
                Caption = 'Pick Date';
                ToolTip = 'Specifies the value of the Pick Date field.';

                trigger OnValidate()
                begin
                    if PickDate < Today then Error('You cannot plan less than today');
                    if PickDate > CalcDate('<1D>', Today)then Error('You can only plan for today or tomorrow');
                end;
            }
            // field(TimeSlot; TimeSlot)
            // {
            //     Caption = 'Time Slot';
            //     ToolTip = 'Specifies the value of the Time Slot field.';

            //     trigger OnLookup(var Text: Text): Boolean var
            //      //   SSDDockTimeSlot2: Record "SSD Dock Time Slots";
            //   //      SSDDockTimeSlot3: Page "SSD Dock Time Slots";
            //     begin
            //         SSDDockTimeSlot2.SetRange("Dock No.", DockCode);
            //         SSDDockTimeSlot3.SetTableView(SSDDockTimeSlot2);
            //         SSDDockTimeSlot3.LookupMode:=true;
            //         SSDDockTimeSlot3.Editable:=false;
            //         if SSDDockTimeSlot3.RunModal() = Action::LookupOK then begin
            //             SSDDockTimeSlot3.GetRecord(SSDDockTimeSlot2);
            //             TimeSlot:=SSDDockTimeSlot2."Slot No.";
            //         end;
            //     end;
            // }
        }
    }
    var DockCode: Code[20];
    TimeSlot: Code[20];
    PickDate: Date;
    procedure SetPickDate(InDate: Date)
    begin
        PickDate:=InDate;
    end;
    procedure SetDock(InDockCode: Code[20])
    begin
        DockCode:=InDockCode;
    end;
    procedure GetPickDate()OutDate: Date begin
        OutDate:=PickDate;
    end;
    procedure GetTimeSlot()OutTimeSlot: Code[20]begin
        OutTimeSlot:=TimeSlot;
    end;
}
