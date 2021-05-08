function AST_D
Screen('CloseAll');

path_way=pwd;

info_subject=inputdlg({'NO.','name','gender','age'},'Set parameters',1,{'1','xxx','male','20'});
info_subject{1}=str2num(info_subject{1});
info_subject{4}=str2num(info_subject{4});

HideCursor;

mkdir(info_subject{2});
date_experiment=date;

window_color=[0 0 0];%color of main screen
offscreen_color=window_color;%color of buffer screen

%define screen
window=Screen('OpenWindow',0,window_color);
window_rect=Screen('Rect',window);%resolution of main screen
offscreen_rect=window_rect;%resolution of buffer screen
offscr0=Screen('OpenOffscreenWindow',window,offscreen_color,offscreen_rect);%white screen

offscr2=Screen('OpenOffscreenWindow',window,offscreen_color,offscreen_rect);%valence rating screen
offscr3=Screen('OpenOffscreenWindow',window,offscreen_color,offscreen_rect);%vivid rating screen
offscr4=Screen('OpenOffscreenWindow',window,offscreen_color,offscreen_rect);%fixation screen

%read images of intruction etc.
cd([path_way,'\picture']);
im_end=imread('end.png');
im_end_texture=Screen('MakeTexture',window,im_end);
im_instr=imread('instruction_experiment.png');
im_instr_texture=Screen('MakeTexture',window,im_instr);

for ii=1:24
    im_story{ii}=imread(['S_',num2str(ii),'.png']);
    im_story_texture{ii}=Screen('MakeTexture',window,im_story{ii});
end

for ii=1:8
    im_valence{ii}=imread(['H_',num2str(ii),'.png']);
    im_valence_texture{ii}=Screen('MakeTexture',window,im_valence{ii});
end
for ii=1:8
    im_vivi{ii}=imread(['V_',num2str(ii),'.png']);
    im_vivi_texture{ii}=Screen('MakeTexture',window,im_vivi{ii});
end

%plot fixation
fixation_length=30;%length of fixation
fixation_width=3;%width of fiation
fixation_color=[255 255 255];%color of fixation
Screen('DrawLine',offscr4,fixation_color,window_rect(3)/2-fixation_length/2,window_rect(4)/2,window_rect(3)/2+fixation_length/2,window_rect(4)/2,fixation_width);
Screen('DrawLine',offscr4,fixation_color,window_rect(3)/2,window_rect(4)/2-fixation_length/2,window_rect(3)/2,window_rect(4)/2+fixation_length/2,fixation_width);

Screen('DrawTexture',offscr2,im_valence_texture{8});
Screen('DrawTexture',offscr3,im_vivi_texture{8});
%set parameters
time_fixation=1;  
[x,y]=WindowCenter(window);

%screen of the introduction slide
Screen('DrawTexture',window,im_instr_texture);
Screen('Flip',window);
flag=1;
while flag
    [a,b,keycode]=KbCheck;
    if keycode(KbName('s'))
        flag=0;
    end
end

%..............task begin.......................

for tt=1:24
    
    Screen('CopyWindow',offscr4,window);
    Screen('Flip',window);
    WaitSecs(time_fixation);
    
    Screen('CopyWindow',offscr0,window);
    Screen('DrawTexture',window,im_story_texture{tt});
    Screen('Flip',window);
    flag=1;
    while flag
        [a,b,keycode]=KbCheck;
        if keycode(KbName('space'))
            flag=0;
        end
    end
    Screen('CopyWindow',offscr2,window);
    Screen('Flip',window);
    
    start_time=GetSecs;
    flag=1;
    while flag
        [a,b,keycode]=KbCheck;
        if a
            switch 1
                case keycode(KbName('1'))      
                    data.rt_valence(tt)=GetSecs-start_time;
                    data.resp_valence(tt)=1;
                    flag=0;
                    Screen('DrawTexture',window,im_valence_texture{1});
                    Screen('Flip',window);
                    WaitSecs(1);
                case keycode(KbName('2'))      
                    data.rt_valence(tt)=GetSecs-start_time;
                    data.resp_valence(tt)=2;
                    flag=0;
                    Screen('DrawTexture',window,im_valence_texture{2});
                    Screen('Flip',window);
                    WaitSecs(1);
                case keycode(KbName('3'))      
                    data.rt_valence(tt)=GetSecs-start_time;
                    data.resp_valence(tt)=3;
                    flag=0;
                    Screen('DrawTexture',window,im_valence_texture{3});
                    Screen('Flip',window);
                    WaitSecs(1);
                case keycode(KbName('4'))      
                    data.rt_valence(tt)=GetSecs-start_time;
                    data.resp_valence(tt)=4;
                    flag=0;
                    Screen('DrawTexture',window,im_valence_texture{4});
                    Screen('Flip',window);
                    WaitSecs(1);
                case keycode(KbName('5'))      
                    data.rt_valence(tt)=GetSecs-start_time;
                    data.resp_valence(tt)=5;
                    flag=0;
                    Screen('DrawTexture',window,im_valence_texture{5});
                    Screen('Flip',window);
                    WaitSecs(1);
                case keycode(KbName('6'))      
                    data.rt_valence(tt)=GetSecs-start_time;
                    data.resp_valence(tt)=6;
                    flag=0;
                    Screen('DrawTexture',window,im_valence_texture{6});
                    Screen('Flip',window);
                    WaitSecs(1);
                case keycode(KbName('7'))      
                    data.rt_valence(tt)=GetSecs-start_time;
                    data.resp_valence(tt)=7;
                    flag=0;
                    Screen('DrawTexture',window,im_valence_texture{7});
                    Screen('Flip',window);
                    WaitSecs(1);
                case keycode(KbName('esc'))
                    Screen('CloseAll');
                    cd([path_way,'\',info_subject{2}]);
                    save AST_result;
                    ShowCursor;
                    cd ..
                    return;
            end
        end
    end
       
    Screen('CopyWindow',offscr3,window);
    Screen('Flip',window);
    
    start_time=GetSecs;
    flag=1;
    while flag
        [a,b,keycode]=KbCheck;
        if a
            switch 1
                case keycode(KbName('1'))      
                    data.rt_vivi(tt)=GetSecs-start_time;
                    data.resp_vivi(tt)=1;
                    flag=0;
                    Screen('DrawTexture',window,im_vivi_texture{1});
                    Screen('Flip',window);
                    WaitSecs(1);
                case keycode(KbName('2'))      
                    data.rt_vivi(tt)=GetSecs-start_time;
                    data.resp_vivi(tt)=2;
                    flag=0;
                    Screen('DrawTexture',window,im_vivi_texture{2});
                    Screen('Flip',window);
                    WaitSecs(1);
                case keycode(KbName('3'))      
                    data.rt_vivi(tt)=GetSecs-start_time;
                    data.resp_vivi(tt)=3;
                    flag=0;
                    Screen('DrawTexture',window,im_vivi_texture{3});
                    Screen('Flip',window);
                    WaitSecs(1);
                case keycode(KbName('4'))     
                    data.rt_vivi(tt)=GetSecs-start_time;
                    data.resp_vivi(tt)=4;
                    flag=0;
                    Screen('DrawTexture',window,im_vivi_texture{4});
                    Screen('Flip',window);
                    WaitSecs(1);
                case keycode(KbName('5'))      
                    data.rt_vivi(tt)=GetSecs-start_time;
                    data.resp_vivi(tt)=5;
                    flag=0;
                    Screen('DrawTexture',window,im_vivi_texture{5});
                    Screen('Flip',window);
                    WaitSecs(1);
                case keycode(KbName('6'))     
                    data.rt_vivi(tt)=GetSecs-start_time;
                    data.resp_vivi(tt)=6;
                    flag=0;
                    Screen('DrawTexture',window,im_vivi_texture{6});
                    Screen('Flip',window);
                    WaitSecs(1);
                case keycode(KbName('7'))   
                    data.rt_vivi(tt)=GetSecs-start_time;
                    data.resp_vivi(tt)=7;
                    flag=0;
                    Screen('DrawTexture',window,im_vivi_texture{7});
                    Screen('Flip',window);
                    WaitSecs(1);
                case keycode(KbName('esc'))
                    Screen('CloseAll');
                    cd([path_way,'\',info_subject{2}]);
                    save AST_result;
                    ShowCursor;
                    cd ..
                    return;
            end
        end
    end
      
end

Screen('CopyWindow',offscr0,window);
Screen('DrawTexture',window,im_end_texture);
Screen('Flip',window);
WaitSecs(5);

ShowCursor;
Screen('CloseAll');
cd([path_way,'\',info_subject{2}]);
save AST_result data info_subject date_experiment;

cd ..

end



