function  plot_response( current, view,data,state, hObject, handles)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if state==1     %Determine animation threshold values
    
    t1=0; t2=4.8; t3=8; t4=12.5; t5=20;

else if state==2
    
        t1=0; t2=4.8;t3=15;t4=22;t5=28;

    
    end

end



h_elecpath=([linspace(261,179,10) linspace(180,149,3) ones(1,17)*150 linspace(151,166,3);linspace(224,78,10) ones(1,3)*77 linspace(78,421,17) ones(1,3)*422])';
m_elecpath=([linspace(261,400,6);linspace(224,386,6)])';

ani_data=animatedline('Color','k','Linewidth',2);

blu=[115 200 255]/255;
redd=[255 53 53]/255;

if view==1
    
    axes(handles.full_view);
    
    h1=[linspace(294,368,12) linspace(369,110,26) linspace(110,428,27) NaN(1,22);linspace(123,185,12) linspace(186,350,26) linspace(380,171,27), NaN(1,22)]';
    mdirecta=[linspace(322,410,9) linspace(411,428,3);linspace(108,184,9) linspace(185,171,3)]';
    mdirecta=[mdirecta;  NaN(length(h1)-length(mdirecta),2)];
    mdirectb=NaN(length(mdirecta),2);
    mdirectc=NaN(length(mdirecta),2);
    
    h2a=h1;
    h2b=NaN(length(h2a),2);
    
    m2=[linspace(322,410,9) linspace(411,110,40);linspace(108,184,9) linspace(185,380,40)]';
    m2=[m2; NaN(length(h1)-length(m2),2)];
    m3=NaN(length(m2),2);
    m4=m3;
    
    f=find(h1(11:end,1)<=m2(11:end,1)+2.75 & h1(11:end,1)>=m2(11:end,1)-2.75,1)+10;
    
    
else
    
    axes(handles.fibre_view);
    
    
    mdirecta=[linspace(400,439,4) ones(1,8)*440;linspace(386,467,4) linspace(467,129,8)]';
    mdirecta=[m_elecpath; mdirecta];
    
    mdirectb=[linspace(400,419,2) ones(1,9)*420;linspace(386,421,2) linspace(421,129,9)]';
    mdirectb=[m_elecpath; mdirectb];
    
    mdirectc=[ones(1,12)*400;linspace(386,129,12)]';
    mdirectc=[m_elecpath; mdirectc];
    
    
    
    hpath1=[ones(1,4)*167 linspace(168,399,17) ones(1,17)*400 NaN(1,14);linspace(421,386,4) ones(1,17)*385 linspace(384,129,17) NaN(1,14)]';
    hpath2=[linspace(167,419,18) ones(1,20)*420 NaN(1,14); ones(1,18)*422 linspace(421,129,20) NaN(1,14)]';
    
    h1=[h_elecpath; hpath1];
    
    h2a=h1;
    h2b=[h_elecpath; hpath2];
    m2=[m_elecpath; ([linspace(400,439,4) linspace(440,231,30);linspace(386,467,4) ones(1,30)*467])'];
    mdirecta=[mdirecta; NaN(length(h2a)-length(mdirecta),2)];
    m2=[m2; NaN(length(h2a)-length(m2),2)];
    mdirectb=[mdirectb; NaN(length(h2a)-length(mdirectb),2)];
    
    m3=[m_elecpath;([linspace(400,419,2) linspace(420,227,49);linspace(386,420,2) ones(1,49)*421])'];
    m3=[m3; NaN(length(h2a)-length(m3),2)];
    
    mdirectc=[mdirectc; NaN(length(h2a)-length(mdirectc),2)];
    m4=[m_elecpath;([linspace(400,233,50);ones(1,50)*386])'];
    m4=[m4; NaN(length(h2a)-length(m4),2)];
    
    
end

set(gca,'XTick',[],'YTick',[]);
data=[data NaN(1,2)];

if current>=t1 && current<t2
    
    
else if current>=t2 && current<t3
        
        a_h1 = animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1 );
        
        
        for i=1:length(h1)
 
            addpoints(a_h1,h1(i,1),h1(i,2))
            axes(handles.time_axis)
            addpoints(ani_data,i,data(i))
           
            pause(0.05)
            %drawnow expose     %% nocallbacks

            
        end
        clearpoints(a_h1)

        
    else if current>=t3 && current<t4
            
            if view==1
                m2(f:end,:)=NaN;
                
            end
            
            a_h2a = animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1 );
            a_h2b = animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1 );
            a_m2 = animatedline('Color',redd,'Marker','o','MarkerFaceColor',redd,'MaximumNumPoints',1 );
            a_mdirecta = animatedline('Color',redd,'Marker','o','MarkerFaceColor',redd,'MaximumNumPoints',1 );
            
            for i=1:length(h2a)
                
                
                addpoints(a_h2a,h2a(i,1),h2a(i,2))
                addpoints(a_h2b,h2b(i,1),h2b(i,2))
                addpoints(a_m2,m2(i,1),m2(i,2))
                addpoints(a_mdirecta,mdirecta(i,1),mdirecta(i,2));
                axes(handles.time_axis)
                addpoints(ani_data,i,data(i))
                
                pause(0.065)
                
                %drawnow expose
                
                
            end
            
            
            clearpoints(a_h2a);
            clearpoints(a_m2);
            clearpoints(a_h2b);
            clearpoints(a_mdirecta);
            
            
        else if current>=t4 && current<t5
                
                
                
                f1=find(h2b(11:end,1)<=m3(11:end,1)+1.75 & h2b(11:end,1)>=m3(11:end,1)-1.75,1)+10;
                
                if view==2
                    h2b((f1):end,:)=NaN;
                else
                    m2(f:end,:)=NaN;
                    
                end
                
                m3((f1):end,:)=NaN;
                
                a_h2 = animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1 );
                a_h2b = animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1 );
                a_m2 = animatedline('Color',redd,'Marker','o','MarkerFaceColor',redd,'MaximumNumPoints',1 );
                a_mdirecta = animatedline('Color',redd,'Marker','o','MarkerFaceColor',redd,'MaximumNumPoints',1 );
                a_mdirectb = animatedline('Color',redd,'Marker','o','MarkerFaceColor',redd,'MaximumNumPoints',1 );
                a_m3 = animatedline('Color',redd,'Marker','o','MarkerFaceColor',redd,'MaximumNumPoints',1 );
                
                for i=1:length(h2a)
                    
                    addpoints(a_h2,h2a(i,1),h2a(i,2))
                    addpoints(a_m2,m2(i,1),m2(i,2))
                    addpoints(a_h2b,h2b(i,1),h2b(i,2))
                    addpoints(a_mdirecta,mdirecta(i,1),mdirecta(i,2));
                    addpoints(a_mdirectb,mdirectb(i,1),mdirectb(i,2));
                    addpoints(a_m3,m3(i,1),m3(i,2))
                    
                    axes(handles.time_axis)
                    addpoints(ani_data,i,data(i))
                    
                    pause(0.065);
                    %drawnow expose;
                    
                    
                    
                end
                
                clearpoints(a_h2);
                clearpoints(a_m2);
                clearpoints(a_h2b);
                clearpoints(a_mdirecta);
                clearpoints(a_mdirectb);
                clearpoints(a_m3);
                
            else
                
                f1=find(h2b(11:end,1)<=m3(11:end,1)+1.75 & h2b(11:end,1)>=m3(11:end,1)-1.75,1)+10;
                f2=find(h2a(11:end,1)<=m4(11:end,1)+4 & h2a(11:end,1)>=m4(11:end,1)-4,1)+10;
                
                if view==1
                    h2a(f:end,:)=NaN;
                    m2(f:end,:)=NaN;
                end
                
                
                h2b((f1):end,:)=NaN;
                m3((f1):end,:)=NaN;
                h2a((f2):end,:)=NaN;
                m4((f2):end,:)=NaN;
                
                a_h2 = animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1 );
                a_m2 = animatedline('Color',redd,'Marker','o','MarkerFaceColor',redd,'MaximumNumPoints',1 );
                a_h2b = animatedline('Color',blu,'Marker','o','MarkerFaceColor',blu,'MaximumNumPoints',1 );
                a_mdirecta = animatedline('Color',redd,'Marker','o','MarkerFaceColor',redd,'MaximumNumPoints',1 );
                a_mdirectb = animatedline('Color',redd,'Marker','o','MarkerFaceColor',redd,'MaximumNumPoints',1 );
                a_m3 = animatedline('Color',redd,'Marker','o','MarkerFaceColor',redd,'MaximumNumPoints',1 );
                a_mdirectc = animatedline('Color',redd,'Marker','o','MarkerFaceColor',redd,'MaximumNumPoints',1 );
                a_m4 = animatedline('Color',redd,'Marker','o','MarkerFaceColor',redd,'MaximumNumPoints',1 );
                
                
                for i=1:length(h2a)
                    
                    
                    addpoints(a_h2,h2a(i,1),h2a(i,2))
                    addpoints(a_m2,m2(i,1),m2(i,2))
                    addpoints(a_h2b,h2b(i,1),h2b(i,2))
                    addpoints(a_mdirecta,mdirecta(i,1),mdirecta(i,2));
                    addpoints(a_mdirectb,mdirectb(i,1),mdirectb(i,2));
                    addpoints(a_m3,m3(i,1),m3(i,2))
                    addpoints(a_mdirectc,mdirectc(i,1),mdirectc(i,2));
                    addpoints(a_m4,m4(i,1),m4(i,2))
                    axes(handles.time_axis)
                    addpoints(ani_data,i,data(i))
                    
                    pause(0.065);
                    %drawnow expose;
                    
                end
                
                clearpoints(a_h2);
                clearpoints(a_m2);
                clearpoints(a_h2b);
                clearpoints(a_mdirecta);
                clearpoints(a_mdirectb);
                clearpoints(a_m3);
                clearpoints(a_mdirectc);
                clearpoints(a_m4);
                
                
            end
        end
        
    end
    
end



end

