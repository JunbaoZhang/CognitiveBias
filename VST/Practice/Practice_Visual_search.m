function visual_search
Screen('CloseAll');

HideCursor;

%set parameters
time_fixation=1;  
distance=200;  %distance between the center of face image and the center of the screen(pixels)
angle=60;
width=130;   %width of the face image
height=150;%height of the face image

window_color=[0 0 0];%color of main screen
offscreen_color=window_color;%color of buffer screen

%define screen
window=Screen('OpenWindow',0,window_color);
window_rect=Screen('Rect',window);%resolution of main screen
offscreen_rect=window_rect;%resolution of buffer screen
offscr0=Screen('OpenOffscreenWindow',window,offscreen_color,offscreen_rect);%white screen
offscr2=Screen('OpenOffscreenWindow',window,offscreen_color,offscreen_rect);%target image screen
offscr4=Screen('OpenOffscreenWindow',window,offscreen_color,offscreen_rect);%fixation screen

%position of the center of the six face images
[x,y]=WindowCenter(window);
coordinate_position_1=[x,y-distance];
coordinate_position_2=[x+sqrt(3)*distance/2,y-distance/2];
coordinate_position_3=[x+sqrt(3)*distance/2,y+distance/2];
coordinate_position_4=[x,y+distance];
coordinate_position_5=[x-sqrt(3)*distance/2,y+distance/2];
coordinate_position_6=[x-sqrt(3)*distance/2,y-distance/2];

%position of the six face images
rect_position_1=[coordinate_position_1(1)-width/2,coordinate_position_1(2)-height/2,coordinate_position_1(1)+width/2,coordinate_position_1(2)+height/2];
rect_position_2=[coordinate_position_2(1)-width/2,coordinate_position_2(2)-height/2,coordinate_position_2(1)+width/2,coordinate_position_2(2)+height/2];
rect_position_3=[coordinate_position_3(1)-width/2,coordinate_position_3(2)-height/2,coordinate_position_3(1)+width/2,coordinate_position_3(2)+height/2];
rect_position_4=[coordinate_position_4(1)-width/2,coordinate_position_4(2)-height/2,coordinate_position_4(1)+width/2,coordinate_position_4(2)+height/2];
rect_position_5=[coordinate_position_5(1)-width/2,coordinate_position_5(2)-height/2,coordinate_position_5(1)+width/2,coordinate_position_5(2)+height/2];
rect_position_6=[coordinate_position_6(1)-width/2,coordinate_position_6(2)-height/2,coordinate_position_6(1)+width/2,coordinate_position_6(2)+height/2];
rect_position={rect_position_1,rect_position_2,rect_position_3,rect_position_4,rect_position_5,rect_position_6};

%read images of intruction etc.
cd ..
path_way=pwd;
cd([path_way,'\picture']);

im_instr=imread('instruction_experiment.png');
im_instr_texture=Screen('MakeTexture',window,im_instr);


im_E{1}=imread('E_1.bmp');
im_E{2}=imread('E_2.bmp');
im_E{3}=imread('E_3.bmp');
im_E{4}=imread('E_4.bmp');
im_N{1}=imread('N_1.bmp');
im_N{2}=imread('N_2.bmp');
im_N{3}=imread('N_3.bmp');
im_N{4}=imread('N_4.bmp');
im_EE{1}=imresize(im_E{1},[width,height]);%resize the original image
im_EE{2}=imresize(im_E{2},[width,height]);
im_EE{3}=imresize(im_E{3},[width,height]);
im_EE{4}=imresize(im_E{4},[width,height]);
im_NN{1}=imresize(im_N{1},[width,height]);
im_NN{2}=imresize(im_N{2},[width,height]);
im_NN{3}=imresize(im_N{3},[width,height]);
im_NN{4}=imresize(im_N{4},[width,height]);

im_E_texture{1}=Screen('MakeTexture',window,im_EE{1});
im_E_texture{2}=Screen('MakeTexture',window,im_EE{2});
im_E_texture{3}=Screen('MakeTexture',window,im_EE{3});
im_E_texture{4}=Screen('MakeTexture',window,im_EE{4});
im_N_texture{1}=Screen('MakeTexture',window,im_NN{1});
im_N_texture{2}=Screen('MakeTexture',window,im_NN{2});
im_N_texture{3}=Screen('MakeTexture',window,im_NN{3});
im_N_texture{4}=Screen('MakeTexture',window,im_NN{4});

%plot fixation
fixation_length=30;%length of fixation
fixation_width=3;%width of fiation
fixation_color=[255 255 255];%color of fixation
Screen('DrawLine',offscr4,fixation_color,window_rect(3)/2-fixation_length/2,window_rect(4)/2,window_rect(3)/2+fixation_length/2,window_rect(4)/2,fixation_width);
Screen('DrawLine',offscr4,fixation_color,window_rect(3)/2,window_rect(4)/2-fixation_length/2,window_rect(3)/2,window_rect(4)/2+fixation_length/2,fixation_width);

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
seq_condition=[7 1 2 5 6 3 4];
seq_position=[1 3 5 4 5 6 1];
seq_iti=[1.5 2 2.5 1.5 2 1.5 1];
for tt=1:length(seq_condition)
    
    Screen('CopyWindow',offscr4,window);
    Screen('Flip',window);
    WaitSecs(time_fixation);
    Screen('CopyWindow',offscr4,offscr2);
    
    switch seq_condition(tt)
        case 1 %sad within neutral
            for ii=1:6
                Screen('DrawTexture',offscr2,im_N_texture{4},[],rect_position{ii});
            end
            Screen('DrawTexture',offscr2,im_E_texture{4},[],rect_position{seq_position(tt)});
            
            Screen('CopyWindow',offscr2,window);
            Screen('Flip',window);
            start_time=GetSecs;
            flag=1;
            while flag
                [a,b,keycode]=KbCheck;
                if a
                    switch 1
                        case keycode(KbName('g'))      %"G" key is pressed£¬recorded as 1 
                            
                            flag=0;
                        case keycode(KbName('h'))      %"H" key is pressed£¬recorded as 2
                            
                            flag=0;
                        case keycode(KbName('esc'))
                            Screen('CloseAll');
                            
                            ShowCursor;
                            cd ..
                            return;
                    end
                end
            end
            
        case 2 %sad within neutral
            for ii=1:6
                Screen('DrawTexture',offscr2,im_N_texture{3},[],rect_position{ii});
            end
            Screen('DrawTexture',offscr2,im_E_texture{3},[],rect_position{seq_position(tt)});
            
            Screen('CopyWindow',offscr2,window);
            Screen('Flip',window);
            start_time=GetSecs;
            flag=1;
            while flag
                [a,b,keycode]=KbCheck;
                if a
                    switch 1
                        case keycode(KbName('g'))
                            
                            flag=0;
                        case keycode(KbName('h'))
                            
                            flag=0;
                        case keycode(KbName('esc'))
                            Screen('CloseAll');
                            
                            ShowCursor;
                            cd ..
                            return;
                    end
                end
            end
        case 3 %neutral within sad
            for ii=1:6
                Screen('DrawTexture',offscr2,im_E_texture{1},[],rect_position{ii});
            end
            Screen('DrawTexture',offscr2,im_N_texture{1},[],rect_position{seq_position(tt)});
            
            Screen('CopyWindow',offscr2,window);
            Screen('Flip',window);
            start_time=GetSecs;
            flag=1;
            while flag
                [a,b,keycode]=KbCheck;
                if a
                    switch 1
                        case keycode(KbName('g'))
                            
                            flag=0;
                        case keycode(KbName('h'))
                            
                            flag=0;
                        case keycode(KbName('esc'))
                            Screen('CloseAll');
                            
                            ShowCursor;
                            cd ..
                            return;
                    end
                end
            end
            
        case 4 %neutral within sad
            for ii=1:6
                Screen('DrawTexture',offscr2,im_E_texture{4},[],rect_position{ii});
            end
            Screen('DrawTexture',offscr2,im_N_texture{4},[],rect_position{seq_position(tt)});
            
            Screen('CopyWindow',offscr2,window);
            Screen('Flip',window);
            start_time=GetSecs;
            flag=1;
            while flag
                [a,b,keycode]=KbCheck;
                if a
                    switch 1
                        case keycode(KbName('g'))
                            
                            flag=0;
                        case keycode(KbName('h'))
                            
                            flag=0;
                        case keycode(KbName('esc'))
                            Screen('CloseAll');
                            
                            ShowCursor;
                            cd ..
                            return;
                    end
                end
            end
            
        case 5 %all sad
            for ii=1:6
                Screen('DrawTexture',offscr2,im_E_texture{2},[],rect_position{ii});
            end
                       
            Screen('CopyWindow',offscr2,window);
            Screen('Flip',window);
            start_time=GetSecs;
            flag=1;
            while flag
                [a,b,keycode]=KbCheck;
                if a
                    switch 1
                        case keycode(KbName('g'))
                            
                            flag=0;
                        case keycode(KbName('h'))
                            
                            flag=0;
                        case keycode(KbName('esc'))
                            Screen('CloseAll');
                            
                            ShowCursor;
                            cd ..
                            return;
                    end
                end
            end
            
        case 6 %all sad
            for ii=1:6
                Screen('DrawTexture',offscr2,im_E_texture{4},[],rect_position{ii});
            end
                                   
            Screen('CopyWindow',offscr2,window);
            Screen('Flip',window);
            start_time=GetSecs;
            flag=1;
            while flag
                [a,b,keycode]=KbCheck;
                if a
                    switch 1
                        case keycode(KbName('g'))
                            
                            flag=0;
                        case keycode(KbName('h'))
                            
                            flag=0;
                        case keycode(KbName('esc'))
                            Screen('CloseAll');
                            
                            ShowCursor;
                            cd ..
                            return;
                    end
                end
            end
            
        case 7 %all neutral
            for ii=1:6
                Screen('DrawTexture',offscr2,im_N_texture{2},[],rect_position{ii});
            end
                                    
            Screen('CopyWindow',offscr2,window);
            Screen('Flip',window);
            start_time=GetSecs;
            flag=1;
            while flag
                [a,b,keycode]=KbCheck;
                if a
                    switch 1
                        case keycode(KbName('g'))
                            
                            flag=0;
                        case keycode(KbName('h'))
                            
                            flag=0;
                        case keycode(KbName('esc'))
                            Screen('CloseAll');
                            
                            ShowCursor;
                            cd ..
                            return;
                    end
                end
            end
    end
        
    Screen('CopyWindow',offscr0,window);
    Screen('Flip',window);
    WaitSecs(seq_iti(tt));
            
end

ShowCursor;
Screen('CloseAll');
cd ..

end



