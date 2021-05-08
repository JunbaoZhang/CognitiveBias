function Word_identification
Screen('CloseAll');

path_way=pwd;
refresh_rate = 120; %refresh rate of the computer
info_subject=inputdlg({'time1(frame)','time2(frame)','time3(frame)','name'},'Set parameters',1,{'9','8','7','xxx'});
info_subject{1}=str2num(info_subject{1})/refresh_rate-1/refresh_rate+0.001;
info_subject{2}=str2num(info_subject{2})/refresh_rate-1/refresh_rate+0.001;
info_subject{3}=str2num(info_subject{3})/refresh_rate-1/refresh_rate+0.001;
info_subject{4}=str2num(info_subject{4});

words=1:1:48;

mkdir(info_subject{4});
HideCursor;

window_color=[0 0 0];%color of main screen
offscreen_color=window_color;%color of buffer screen

%define screen
window=Screen('OpenWindow',0,window_color);
window_rect=Screen('Rect',window);%resolution of main screen
offscreen_rect=window_rect;%resolution of buffer screen
offscr0=Screen('OpenOffscreenWindow',window,offscreen_color,offscreen_rect);%white screen
offscr1=Screen('OpenOffscreenWindow',window,offscreen_color,offscreen_rect);%mask screen
offscr2=Screen('OpenOffscreenWindow',window,offscreen_color,offscreen_rect);%target image screen
offscr3=Screen('OpenOffscreenWindow',window,offscreen_color,offscreen_rect);%fixation screen

%read images of intruction etc.
cd([path_way,'\picture']);

im_instr2=imread('instruction_experiment_2.png');
im_instr2_texture=Screen('MakeTexture',window,im_instr2);

im_mask=imread('mask.jpg');
im_mask_texture=Screen('MakeTexture',window,im_mask);

flag=1;
for ii=words(1):words(end)
    im_neutral{flag}=imread(['N_',num2str(ii),'.png']);
    im_neutral_texture{flag}=Screen('MakeTexture',window,im_neutral{flag});
    flag=flag+1;
end

%plot fixation
fixation_length=30;%length of fixation
fixation_width=3;%width of fiation
fixation_color=[255 255 255];%color of fixation
Screen('DrawLine',offscr3,fixation_color,window_rect(3)/2-fixation_length/2,window_rect(4)/2,window_rect(3)/2+fixation_length/2,window_rect(4)/2,fixation_width);
Screen('DrawLine',offscr3,fixation_color,window_rect(3)/2,window_rect(4)/2-fixation_length/2,window_rect(3)/2,window_rect(4)/2+fixation_length/2,fixation_width);

Screen('DrawTexture',offscr1,im_mask_texture);

%set parameters
time_fixation=1;  
time_word_1=4;
time_read=3;
time_word_2=[repmat([info_subject{1},info_subject{2},info_subject{3}],[1,16])];
[x,y]=WindowCenter(window);

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

for tt=1:length(words)
    
    Screen('CopyWindow',offscr3,window);
    Screen('Flip',window);
    WaitSecs(time_fixation);
     
   %%%%%%%%%%%%test%%%%%%%%%%%%%%%%% 
    Screen('CopyWindow',offscr1,window);
    Screen('Flip',window);
    WaitSecs(1);
    %%%%%%%%%%%%%%test%%%%%%%%%%%%%%%%
    Screen('DrawTexture',offscr2,im_neutral_texture{tt});
    
    Screen('CopyWindow',offscr2,window);
    Screen('Flip',window);
    start_time=GetSecs;
    WaitSecs(time_word_2(tt));
        
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
                    cd([path_way,'\',info_subject{4}]);
                    save identification_result data;
                    ShowCursor;
                    cd ..
                    return;
            end
        end
    end
   
end
    
ShowCursor;
Screen('CloseAll');
cd([path_way,'\',info_subject{4}]);
save identification_result data;
cd ..

end



