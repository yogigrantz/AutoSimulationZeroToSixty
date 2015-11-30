print("Swiftstub Running XCode 7.1 Swift 2 - Auto Performance Simulation Program")
// Coded at http://swiftstub.com/274463480
// By: Yogi Grantz - Car Enthusiast, .NET Developer, C# Nuts, Learning Swift :)

class Kinematics {
    var Weight = Double(0.0);
    var MaxTorque = Double(0.0);
    var RedLineRPM = Double(0.0);
    var ClutchedRPM = Double(0.0);
    var WheelDiameter = Double(0.0);
    var TireProfile = Double(0.0);
    var TireWidth = Double(0.0);
    var GearRatios = [Double](count:5, repeatedValue: 0.0);
    var FinalDriveRatio = Double(0.0);
    var CoeffOfFriction = Double(0.0);
    var Make = String("");
    
    // Assuming constant Torque;
    func ZeroToSixty() {
        //var a = Double(0.0);
        var v = Double(0.0);
        var rpm = Double(0.0);
        let dt = Double(0.05);
        var t = Double(0.0);
        var gearShift = 0;
        var slipClutch = "";
        while (v < 60 * 5280.0 / 3600.0) 
        {
            if (rpm > RedLineRPM) {
                gearShift += 1;
            }
            rpm = v * GearRatios[gearShift] * FinalDriveRatio * 60.0 / (2 * 3.1415296 * ArmLength());
            if (rpm < ClutchedRPM) {
                rpm = ClutchedRPM;
                slipClutch = " - partial clutch"
            }
            else {
                slipClutch = "";
            }
            v += Acceleration(GearRatios[gearShift]) * dt;
            t += dt;
            print (String(format:"%.02f",t) + " s: " + String(format:"%.02f", v * 3600 / 5280) + " mph @ " + String(format:"%.00f",rpm) + " RPM, Gear: " + String(gearShift + 1) + " " + slipClutch);
        }
        
    }
    
    // Arm Length in ft.
    func ArmLength() -> Double {
        var arm = 0.0;
        arm = WheelDiameter / 2.0 / 12.0;
        arm += TireWidth / 25.4 / 12.0 * TireProfile / 100;
        return arm;
    }
    
    // Thrust in lbs.
    func Thrust(let gearRatio:Double) -> Double {
        var force = 0.0;
        force = MaxTorque / ArmLength() * gearRatio * FinalDriveRatio * CoeffOfFriction;
        return force;
    }
    
    // Acceleration in ft/s2
    func Acceleration(let gearRatio:Double) -> Double {
        var a = 0.0;
        a = Thrust(gearRatio) / (Weight / 32.174);
        return a;
    }
    
}

// Change your car parameters here *******************************************
let k = Kinematics();
k.Make = "1989 Ford Mustang GT";
k.Weight = 3500;
k.MaxTorque = 285;
k.RedLineRPM = 5500;
k.ClutchedRPM = 3700;
k.WheelDiameter = 15;
k.TireWidth = 235;
k.TireProfile = 60
k.GearRatios = [3.9, 3.2, 2.3, 1.2, 0.78];
k.FinalDriveRatio = 2.71;
k.CoeffOfFriction = 0.8;

print("===============================");
print(k.Make + " - Simulated 0-60");
print("-------------------------------");
print(k.Make);
k.ZeroToSixty();
print("===============================");
