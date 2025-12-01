pageextension 60014 "SSD Auto Item Card" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field("SSD Pallet Type"; Rec."SSD Pallet Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Pallet Type field.', Comment = '%';
            }
            field("SSD Low Flash"; Rec."SSD Low Flash")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Low Flash field.', Comment = '%';
            }
            field("SSD Item SubType"; Rec."SSD Item SubType")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item SubType field.', Comment = '%';
            }
            field("SSD Storage Type"; Rec."SSD Storage Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Storage Type field.', Comment = '%';
            }
            field("SSD Consumption Station"; Rec."SSD Consumption Station")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Consumption Station field.', Comment = '%';
            }
        }
        addbefore("Pack Size")
        {
            field(Packing; Rec."SSD Packing")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Packing field.', Comment = '%';
            }
        }
    }
    actions
    {
        addlast(Navigation_Item)
        {
            action(WarehouseMapping)
            {
                Caption = 'Warehouse Mapping';
                Image = WarehouseSetup;
                ApplicationArea = All;
                ToolTip = 'Executes the Warehouse Mapping action.';
                RunObject = Page "SSD Item Warehouse Mapping";
                RunPageLink = "Item No."=field("No.");
            }
            action(UpdateTracking)
            {
                Caption = 'Update Tracking';
                Image = UpdateDescription;
                ApplicationArea = All;
                ToolTip = 'Executes the Update Tracking action.';
                RunObject = Page "SSD Item Tracking Change";
                RunPageOnRec = true;
            }
        }
        addlast(Category_Process)
        {
            actionref(WarehouseMapping_Promoted; WarehouseMapping)
            {
            }
            actionref(UpdateTracking_Promoted; UpdateTracking)
            {
            }
        }
    }
}
