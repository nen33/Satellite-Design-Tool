function [propulsion, cost] = Propulsion(m,h,life)
% -------------------------------------------------------------------------
% Inputs:
%   h:    altitude [km]
%   m:    dry mass [kg]
%   life: lifetime [years]
% Outputs:
%   prop_parts: struct array containing thruster and tanks 
%   cost:       total cost of propulsion subsystem
% -------------------------------------------------------------------------

% Delta-V
dV = DeltaV(h,life);

% Calculations for Hydrazine system
Isp = 200;
rho = 990;
mp  = rocket_equation(dV,Isp,m);
V   = mp/rho;
r_tank  = ((3*V)/(4*pi))^(1/3) * 1.2;
T_min = 10;
T_max = 30;

% Dry mass of tank, using PMD (from SME Fig. 18.8)
m_tank = (2.7086E-8)*V^3 - (6.2703E-5)*V^2 + (6.6920E-2)*V + 1.3192;

% Approximate thruster dimensions
r_nozzle = r_tank/2;
L = r_tank;
m_thruster = m_tank;

% Cost (from SME Table 11-8)
cost = 20.0 * (V * 1E6)^0.485;

% Output structures
thruster = struct('Name','Thruster',...
    'Subsystem','Propulsion',...
    'Shape','Cylinder',...
    'Mass',m_thruster,...
    'Dim',[L, r_nozzle],...
    'CG_XYZ',[],...
    'Vertices',[],...
    'LocationReq','Specific',...
    'Orientation',[],...
    'Thermal',[],...
    'InertiaMatrix',[],...    
    'RotateToSatBodyFrame', []);

    tank = struct('Name','Tank',...
        'Subsystem','Propulsion',...
        'Shape','Sphere',...
        'Mass',m_tank,...
        'Dim',r_tank,...
        'CG_XYZ',[],...
        'Vertices',[],...
        'LocationReq','Specific',...
        'Orientation',[],...
        'Thermal',[T_min T_max],...
        'InertiaMatrix',[],...    
        'RotateToSatBodyFrame', []);
    
    propulsion.comp = [thruster, tank];
    propulsion.cost = cost;
    propulsion.mass = m_thruster+m_tank;
end

function mprop = rocket_equation(dV, Isp, mf)
    mprop = mf*(exp(dV/(9.81*Isp))-1);
end
    