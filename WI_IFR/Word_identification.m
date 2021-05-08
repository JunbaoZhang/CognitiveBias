function Word_identification
Screen('CloseAll');

path_way=pwd;
refresh_rate=120;%refresh rate of the computer
load seq_identification.mat;%load valence and orders of the image to be presented

info_subject=inputdlg({'NO.','name','gender','age','sequence number(1 or 2) ','time£¨frame£©'},'Set parameters',1,{'1','xxx','male','20','1',''});
info_subject{1}=str2num(info_subject{1});
info_subject{5}=str2num(info_subject{5});
info_subject{6}=str2num(info_subject{6});
if isempty(info_subject{6})
    disp('%%%%%%%%%%%%%%...please input number of frames£¡...%%%%%%%%%%%%%%%%');
    return;
end
if info_subject{5}==1
    one_negative=1:1:16;
    one_neutral=1:1:16;
    one_positive=1:1:16;
else
    one_negative=17:1:32;
    one_neutral=17:1:32;
    one_positive=17:1:32;
end

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
offscr1=Screen('OpenOffscreenWindow',window,offscreen_color,offscreen_rect);%mask screen
offscr2=Screen('OpenOffscreenWindow',window,offscreen_color,offscreen_rect);%target image screen
offscr3=Screen('OpenOffscreenWindow',window,offscreen_color,offscreen_rect);%rating screen
offscr4=Screen('OpenOffscreenWindow',window,offscreen_color,offscreen_rect);%fixation screen

%read images of intruction etc.
cd([path_way,'\picture']);
im_end=imread('end.png');
im_end_texture=Screen('MakeTexture',window,im_end);
im_instr1=imread('instruction_experiment_1.png');
im_instr1_texture=Screen('MakeTexture',window,im_instr1);
im_instr2=imread('instruction_experiment_2.png');
im_instr2_texture=Screen('MakeTexture',window,im_instr2);
im_rest=imread('rest.png');
im_rest_texture=Screen('MakeTexture',window,im_rest);
im_continue=imread('continue.png');
im_continue_texture=Screen('MakeTexture',window,im_continue);
im_mask=imread('mask.jpg');
im_mask_texture=Screen('MakeTexture',window,im_mask);

for ii=1:6
    im_rate{ii}=imread(['rate_',num2str(ii),'.png']);
    im_rate_texture{ii}=Screen('MakeTexture',window,im_rate{ii});
end

for ii=1:32
    im_positive{ii}=imread(['P_',num2str(ii),'.png']);
    im_positive_texture{ii}=Screen('MakeTexture',window,im_positive{ii});
end
for ii=1:32
    im_neutral{ii}=imread(['N_',num2str(ii),'.png']);
    im_neutral_texture{ii}=Screen('MakeTexture',window,im_neutral{ii});
end
for ii=1:32
    im_negative{ii}=imread(['D_',num2str(ii),'.png']);
    im_negative_texture{ii}=Screen('MakeTexture',window,im_negative{ii});
end

%plot fixation
fixation_length=30;%length of fixation
fixation_width=3;%width of fiation
fixation_color=[255 255 255];%color of fixation
Screen('DrawLine',offscr4,fixation_color,window_rect(3)/2-fixation_length/2,window_rect(4)/2,window_rect(3)/2+fixation_length/2,window_rect(4)/2,fixation_width);
Screen('DrawLine',offscr4,fixation_color,window_rect(3)/2,window_rect(4)/2-fixation_length/2,window_rect(3)/2,window_rect(4)/2+fixation_length/2,fixation_width);

Screen('DrawTexture',offscr1,im_mask_texture);
Screen('DrawTexture',offscr3,im_rate_texture{6});
%set parameters
time_fixation=1;  
time_word_1=4;
time_read=3;
time_word_2=info_subject{6}/refresh_rate-1/refresh_rate+0.001;
[x,y]=WindowCenter(window);

%screen of the introduction slide
Screen('DrawTexture',window,im_instr1_texture);
Screen('Flip',window);
flag=1;
while flag
    [a,b,keycode]=KbCheck;
    if keycode(KbName('s'))
        flag=0;
    end
end

%%%%%%%%%%%%%%%%%First phase£ºrating for the words%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%..............task begin.......................
cc_1=1;%%%%%%%%%%%%counters of 3 conditions
cc_2=1;
cc_3=1;

for tt=1:length(one_valence)
    
    Screen('CopyWindow',offscr4,window);
    Screen('Flip',window);
    WaitSecs(time_fixation);
       
    switch one_valence(tt)
        case 1
            Screen('DrawTexture',offscr2,im_positive_texture{one_positive(cc_1)});
            cc_1=cc_1+1;
            Screen('CopyWindow',offscr2,window);
            Screen('Flip',window);
            WaitSecs(time_word_1);
            
            Screen('CopyWindow',offscr3,window);
            Screen('Flip',window);
            start_time=GetSecs;
            flag=1;
            while flag
                [a,b,keycode]=KbCheck;
                if a
                    switch 1
                        case keycode(KbName('1'))      
                            data.rt(tt)=GetSecs-start_time;
                            data.resp(tt)=1;
                            flag=0;
                            Screen('DrawTexture',window,im_rate_texture{1});
                            Screen('Flip',window);
                            WaitSecs(1);
                        case keycode(KbName('2'))      
                            data.rt(tt)=GetSecs-start_time;
                            data.resp(tt)=2;
                            flag=0;
                            Screen('DrawTexture',window,im_rate_texture{2});
                            Screen('Flip',window);
                            WaitSecs(1);
                        case keycode(KbName('3'))      
                            data.rt(tt)=GetSecs-start_time;
                            data.resp(tt)=3;
                            flag=0;
                            Screen('DrawTexture',window,im_rate_texture{3});
                            Screen('Flip',window);
                            WaitSecs(1);
                        case keycode(KbName('4'))     
                            data.rt(tt)=GetSecs-start_time;
                            data.resp(tt)=4;
                            flag=0;
                            Screen('DrawTexture',window,im_rate_texture{4});
                            Screen('Flip',window);
                            WaitSecs(1);
                        case keycode(KbName('5'))      
                            data.rt(tt)=GetSecs-start_time;
                            data.resp(tt)=5;
                            flag=0;
                            Screen('DrawTexture',window,im_rate_texture{5});
                            Screen('Flip',window);
                            WaitSecs(1);
                        case keycode(KbName('esc'))
                            Screen('CloseAll');
                            cd([path_way,'\',info_subject{2}]);
                            save identification_result;
                            ShowCursor;
                            cd ..
                            return;
                    end
                end
            end
            case 2
            Screen('DrawTexture',offscr2,im_neutral_texture{one_neutral(cc_2)});
            cc_2=cc_2+1;
            Screen('CopyWindow',offscr2,window);
            Screen('Flip',window);
            WaitSecs(time_word_1);
            
            Screen('CopyWindow',offscr3,window);
            Screen('Flip',window);
            start_time=GetSecs;
            flag=1;
            while flag
                [a,b,keycode]=KbCheck;
                if a
                    switch 1
                        case keycode(KbName('1'))      
                            data.rt(tt)=GetSecs-start_time;
                            data.resp(tt)=1;
                            flag=0;
                            Screen('DrawTexture',window,im_rate_texture{1});
                            Screen('Flip',window);
                            WaitSecs(1);
                        case keycode(KbName('2'))      
                            data.rt(tt)=GetSecs-start_time;
                            data.resp(tt)=2;
                            flag=0;
                            Screen('DrawTexture',window,im_rate_texture{2});
                            Screen('Flip',window);
                            WaitSecs(1);
                        case keycode(KbName('3'))     
                            data.rt(tt)=GetSecs-start_time;
                            data.resp(tt)=3;
                            flag=0;
                            Screen('DrawTexture',window,im_rate_texture{3});
                            Screen('Flip',window);
                            WaitSecs(1);
                        case keycode(KbName('4'))      
                            data.rt(tt)=GetSecs-start_time;
                            data.resp(tt)=4;
                            flag=0;
                            Screen('DrawTexture',window,im_rate_texture{4});
                            Screen('Flip',window);
                            WaitSecs(1);
                        case keycode(KbName('5'))      
                            data.rt(tt)=GetSecs-start_time;
                            data.resp(tt)=5;
                            flag=0;
                            Screen('DrawTexture',window,im_rate_texture{5});
                            Screen('Flip',window);
                            WaitSecs(1);
                        case keycode(KbName('esc'))
                            Screen('CloseAll');
                            cd([path_way,'\',info_subject{2}]);
                            save identification_result;
                            ShowCursor;
                            cd ..
                            return;
                    end
                end
            end
            case 3
            Screen('DrawTexture',offscr2,im_negative_texture{one_negative(cc_3)});
            cc_3=cc_3+1;
            Screen('CopyWindow',offscr2,window);
            Screen('Flip',window);
            WaitSecs(time_word_1);
            
            Screen('CopyWindow',offscr3,window);
            Screen('Flip',window);
            start_time=GetSecs;
            flag=1;
            while flag
                [a,b,keycode]=KbCheck;
                if a
                    switch 1
                        case keycode(KbName('1'))      
                            data.rt(tt)=GetSecs-start_time;
                            data.resp(tt)=1;
                            flag=0;
                            Screen('DrawTexture',window,im_rate_texture{1});
                            Screen('Flip',window);
                            WaitSecs(1);
                        case keycode(KbName('2'))      
                            data.rt(tt)=GetSecs-start_time;
                            data.resp(tt)=2;
                            flag=0;
                            Screen('DrawTexture',window,im_rate_texture{2});
                            Screen('Flip',window);
                            WaitSecs(1);
                        case keycode(KbName('3'))      
                            data.rt(tt)=GetSecs-start_time;
                            data.resp(tt)=3;
                            flag=0;
                            Screen('DrawTexture',window,im_rate_texture{3});
                            Screen('Flip',window);
                            WaitSecs(1);
                        case keycode(KbName('4'))     
                            data.rt(tt)=GetSecs-start_time;
                            data.resp(tt)=4;
                            flag=0;
                            Screen('DrawTexture',window,im_rate_texture{4});
                            Screen('Flip',window);
                            WaitSecs(1);
                        case keycode(KbName('5'))      
                            data.rt(tt)=GetSecs-start_time;
                            data.resp(tt)=5;
                            flag=0;
                            Screen('DrawTexture',window,im_rate_texture{5});
                            Screen('Flip',window);
                            WaitSecs(1);
                        case keycode(KbName('esc'))
                            Screen('CloseAll');
                            cd([path_way,'\',info_subject{2}]);
                            save identification_result;
                            ShowCursor;
                            cd ..
                            return;
                    end
                end
            end
            
             
    end
    
end

%%%%%%%%%%%%%%%%%Second phase£ºword identification%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Screen('DrawTexture',window,im_rest_texture);
Screen('Flip',window);
WaitSecs(30);
Screen('CopyWindow',offscr0,window);
Screen('DrawTexture',window,im_continue_texture);
Screen('Flip',window);
WaitSecs(5);

%screen of the introduction slide
Screen('CopyWindow',offscr0,window);
Screen('DrawTexture',window,im_instr2_texture);
Screen('Flip',window);
flag=1;
while flag
    [a,b,keycode]=KbCheck;
    if keycode(KbName('s'))
        flag=0;
    end
end

cc_1=1;%%%%%%%%%%%%counters of 3 conditions
cc_2=1;
cc_3=1;

for tt=1:length(two_valence)
    
    Screen('CopyWindow',offscr4,window);
    Screen('Flip',window);
    WaitSecs(time_fixation);
     
   %%%%%%%%%%%%test%%%%%%%%%%%%%%%%% 
    Screen('CopyWindow',offscr1,window);
    Screen('Flip',window);
    WaitSecs(1);
  %%%%%%%%%%%%%%test%%%%%%%%%%%%%%%%  
    switch two_valence(tt)
        case 1
            Screen('DrawTexture',offscr2,im_positive_texture{two_positive(cc_1)});
            cc_1=cc_1+1;
            Screen('CopyWindow',offscr2,window);
            Screen('Flip',window);
            start_time=GetSecs;
            WaitSecs(time_word_2);
                      
        case 2
            Screen('DrawTexture',offscr2,im_neutral_texture{two_neutral(cc_2)});
            cc_2=cc_2+1;
            Screen('CopyWindow',offscr2,window);
            Screen('Flip',window);
            start_time=GetSecs;
            WaitSecs(time_word_2);
                        
        case 3
            Screen('DrawTexture',offscr2,im_negative_texture{two_negative(cc_3)});
            cc_3=cc_3+1;
            Screen('CopyWindow',offscr2,window);
            Screen('Flip',window);
            start_time=GetSecs;
            WaitSecs(time_word_2);
                                 
    end
    
    Screen('CopyWindow',offscr1,window);
    Screen('Flip',window);
    data.time_word_2(tt)=GetSecs-start_time;
    start_time=GetSecs;
    
    while GetSecs-start_time<time_read
        [a,b,keycode]=KbCheck;
        if a
            switch 1
                case keycode(KbName('esc'))
                    Screen('CloseAll');
                    cd([path_way,'\',info_subject{2}]);
                    save identification_result;
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
save identification_result data one_valence two_valence one_positive one_negative one_neutral two_positive two_negative two_neutral info_subject date_experiment;

cd ..
end



