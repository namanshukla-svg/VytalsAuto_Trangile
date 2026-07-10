table 60020 "SSD Automation Cue"
{
    Caption = 'Automation Cue';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        // field(10; "Dock Actions"; Integer)
        // {
        //     Caption = 'Dock Actions';
        //     FieldClass = FlowField;
        //     CalcFormula = count("SSD Dock" where(Code=field("Location Filter")));
        // }
        // field(20; "Dock Lines"; Integer)
        // {
        //     Caption = 'Dock Lines';
        //     FieldClass = FlowField;
        //     CalcFormula = count("SSD Dock Lines" where("Location Code"=field("Location Filter"), Status=filter(<"Dock Out")));
        // }
        field(30; "Active Drivers"; Integer)
        {
            Caption = 'Drivers';
            FieldClass = FlowField;
            CalcFormula = count("SSD Driver" where(Active=const(true)));
        }
        field(40; "Active Vehicles"; Integer)
        {
            Caption = 'Active Vehicles';
            FieldClass = FlowField;
            CalcFormula = count("SSD Vehicle" where(Active=const(true)));
        }
        field(50; "Gate Inward"; Integer)
        {
            Caption = 'Gate Inward';
            FieldClass = FlowField;
            CalcFormula = count("Gate Entry Header" where("Entry Type"=const(Inward)));
        }
        field(60; "Gate Outward"; Integer)
        {
            Caption = 'Gate Outward';
            FieldClass = FlowField;
            CalcFormula = count("Gate Entry Header" where("Entry Type"=const(Outward)));
        }
        field(70; "Pending Gate-Out -Inward"; Integer)
        {
            Caption = 'Pending Gate-Out -Inward';
            FieldClass = FlowField;
            CalcFormula = count("Posted Gate Entry Header" where("Entry Type"=const(Inward), "SSD Vehicle Status"=filter(<"Gate-Out")));
        }
        field(80; "Pending Gate-Out -Outward"; Integer)
        {
            Caption = 'Pending Gate-Out -Outward';
            FieldClass = FlowField;
            CalcFormula = count("Posted Gate Entry Header" where("Entry Type"=const(Outward), "SSD Vehicle Status"=filter(<"Gate-Out")));
        }
        field(90; "Planned Warehouse Receipts"; Integer)
        {
            Caption = 'Planned Warehouse Receipts';
            FieldClass = FlowField;
            CalcFormula = count("Warehouse Receipt Header" where("Location Code"=field("Location Filter"), "SSD Status"=const(Released)));
        }
        field(100; "Planned Warehouse Shipments"; Integer)
        {
            Caption = 'Planned Warehouse Shipments';
            FieldClass = FlowField;
            CalcFormula = count("Warehouse Shipment Header" where("Location Code"=field("Location Filter"), "Status"=const(Released)));
        }
        field(110; "Sales Lines"; Integer)
        {
            Caption = 'Sales Lines';
            FieldClass = FlowField;
            CalcFormula = count("Sales Line" where("Document Type"=const(Order), "Outstanding Quantity"=filter(<>0), Type=const(Item), "Location Code"=field("Location Filter")));
        }
        field(120; "Purchase Lines"; Integer)
        {
            Caption = 'Purchase Lines';
            FieldClass = FlowField;
            CalcFormula = count("Purchase Line" where("Document Type"=const(Order), "Outstanding Quantity"=filter(<>0), Type=const(Item), "Location Code"=field("Location Filter")));
        }
        field(5000; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
