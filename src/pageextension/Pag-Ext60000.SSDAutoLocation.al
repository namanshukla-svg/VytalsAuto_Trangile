pageextension 60000 "SSD Auto Location" extends "Location List"
{
    actions
    {
        addlast(navigation)
        {
            action(ASRSZone)
            {
                ApplicationArea = All;
                Caption = 'ASRS Zone';
                Image = InventoryCalculation;
                RunObject = Page "SSD ASRS Zone";
                RunPageLink = "Location Code"=field(Code);
                ToolTip = 'Executes the ASRS Zone action.';
            }
            // action(Docks)
            // {
            //     ApplicationArea = All;
            //     Caption = 'Docks';
            //     Image = InventoryCalculation;
            //     RunObject = Page "SSD Docks";
            //     RunPageLink = "Location Code"=field(Code);
            //     ToolTip = 'Executes the Docks action.';
            // }
        }
    }
}
