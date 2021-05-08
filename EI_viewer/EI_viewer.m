function EI_viewer
Screen('CloseAll');

path_way=pwd;
load EI_viewer_seq.mat;%load valence, orders etc. of images

info_subject=inputdlg({'NO.','name','gender','age','sequence number 1 or 2 '},'Set parameters',1,{'1','xxx','male','20','1'});
info_subject{1}=str2num(info_subject{1});
info_subject{4}=str2num(info_subject{4});
info_subject{5}=str2num(info_subject{5});

trial_order=trial_order(info_subject{5},:);
size_trial=[2 60];
trial_order=[trial_order(1,1:60);trial_order(1,61:120)];
CB_order=CB_order(info_subject{5},:);

HideCursor;

mkdir(info_subject{2});
date_experiment=date;

%set parameters
time_im=0.2;%time of an image
time_show=2;%time of a sub-trial
time_baseline1=10;%time of baseline1
time_baseline2=20;%time of baseline2

window_color=[0 0 0];%color of main screen
offscreen_color=window_color;%color of buffer screen

%define screen
window=Screen('OpenWindow',0,window_color);
window_rect=Screen('Rect',window);%resolution of main screen
offscreen_rect=window_rect;%resolution of buffer screen
offscr0=Screen('OpenOffscreenWindow',window,offscreen_color,offscreen_rect);%black screen
offscr1=Screen('OpenOffscreenWindow',window,offscreen_color,offscreen_rect);%target image screen
offscr4=Screen('OpenOffscreenWindow',window,offscreen_color,offscreen_rect);%fixation screen

%read introduction image etc.
cd([path_way,'\picture']);
im_end=imread('end.bmp');
im_end_texture=Screen('MakeTexture',window,im_end);
im_instr=imread('instruction-experiment.bmp');
im_instr_texture=Screen('MakeTexture',window,im_instr);

cd([path_way,'\picture']);

for ii=1:60
    
        im_target{ii}=imread([num2str(picture_all(ii)),'.bmp']);
        im_target_texture{ii}=Screen('MakeTexture',window,im_target{ii});
          
end

%plot fixation
fixation_length=30;%length of fixation
fixation_width=3;%width of fixation
fixation_color=[255 255 255];%color of fixation
Screen('DrawLine',offscr4,fixation_color,window_rect(3)/2-fixation_length/2,window_rect(4)/2,window_rect(3)/2+fixation_length/2,window_rect(4)/2,fixation_width);
Screen('DrawLine',offscr4,fixation_color,window_rect(3)/2,window_rect(4)/2-fixation_length/2,window_rect(3)/2,window_rect(4)/2+fixation_length/2,fixation_width);

%screen of introduction slide
Screen('DrawTexture',window,im_instr_texture);
Screen('Flip',window);

%..............task begin.......................

for tt=1:size_trial(1)
    flag=1;
    while flag
        [a,b,keycode]=KbCheck;
        if keycode(KbName('s'))
            flag=0;
        end
    end
    timetime=GetSecs;
    Screen('CopyWindow',offscr4,window);
    Screen('Flip',window);
    WaitSecs(time_baseline1);
    
    for ii=1:size_trial(2)
        
        Screen('CopyWindow',offscr0,offscr1);
        Screen('DrawTexture',offscr1,im_target_texture{find(picture_all==trial_order(tt,ii))});
             
        %
            start_time=GetSecs;
            
            Screen('CopyWindow',offscr1,window);
            Screen('Flip',window);
            WaitSecs(time_im);
            
            
            Screen('CopyWindow',offscr0,window);
            Screen('Flip',window);
            
            trial_time=GetSecs-start_time;
            WaitSecs(time_show-trial_time);
          
        if ii==10||ii==20||ii==30||ii==40||ii==50
            Screen('CopyWindow',offscr4,window);
            Screen('Flip',window);
            start_time=GetSecs;
            while GetSecs-start_time<time_baseline2
                [a,b,keycode]=KbCheck;
                if keycode(KbName('esc'))
                    Screen('CloseAll');
                    cd([path_way,'\',info_subject{2}]);
                    save('EI_viewer_result');
                    ShowCursor;
                    cd ..
                    return;
                end
            end     
        end
             
    end
    WaitSecs(time_baseline1);
    
    Screen('CopyWindow',offscr0,window);
    Screen('Flip',window);    
    
end

Screen('CopyWindow',offscr0,window);
Screen('DrawTexture',window,im_end_texture);
Screen('Flip',window);
WaitSecs(2);

ShowCursor;
Screen('CloseAll');
cd([path_way,'\',info_subject{2}]);
save EI_viewer_result trial_order CB_order date_experiment info_subject;

cd ..

end












