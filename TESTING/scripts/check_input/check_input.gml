
if (state != states.move and state != states.dash) //if state is not move or dash, check if a key is pressed:
	{
		
	//Player Movement right
	if (keyboard_check_pressed(ord("D")))
	{
		/*moveDirection = 0;*/
		hsp = gridSize;
		vsp = 0;
	}


	//Player movement left
		if (keyboard_check_pressed(ord("A")))
	{
		/*moveDirection = 2;*/
		hsp = -gridSize;
		vsp = 0;
	}


	//Player movement up
	if (keyboard_check_pressed(ord("W")))
	{
		/*moveDirection = 1;*/
		hsp = 0;
		vsp = -gridSize;
	}

	//Player movement down
	if (keyboard_check_pressed(ord("S")))
	{ 
		/*moveDirection = 3;*/
		hsp = 0;
		vsp = gridSize;
	}
	
		
	
	//Turning MoveDirection left 90 degrees
	if (keyboard_check_pressed(ord("Q")))
	{ 
		moveDirection = moveDirection+1
		if (moveDirection>3)
		{
			moveDirection = 0
		}
		
	}
	
	//Turning moveDirection right 90 degrees
	if (keyboard_check_pressed(ord("E")))
	{ 
		moveDirection = moveDirection-1
		if (moveDirection<0)
		{
			moveDirection = 3
		}
	}
	
	
	//Attacking	- if key is pressed execute attack script
		
		if (keyboard_check_pressed(vk_left))
		{
			scr_attack()
		}
	
		
		
	//Player ability Dash 
    if (keyboard_check_pressed(vk_down))
    { 
        var tempDashDistance = dashDistance;
        
        //Takes moveDirection and sets the direction of our dash for checking collisions
        hsp = lengthdir_x(dashDistance * gridSize, moveDirection * 90);
        vsp = lengthdir_y(dashDistance * gridSize, moveDirection * 90);
        state = states.dash; //sets the state to dash
                           
			   
				   
        //Dash collision check for walls/blocks (oWall)
        for(var i = 0;i<dashDistance;i++)//If i is smaller than Distance = add 1 to i but keep i the same, until i is = to dashDistance.
        {
            //Collision:
            if (place_meeting(oTest.x + sign(hsp) + sign(hsp)*(i*gridSize), oTest.y + sign(vsp) + sign(vsp)*(i*gridSize), oWall))
                {
                    tempDashDistance = i; // If there's a wall before we can finish dashing, shorten the dash distance (using temporary variable)
					break;
			   }   		
			
		  }   
		  
		 /*			     USE THIS CODE FOR DISABLING DASHING THROUGH ENEMIES OR OTHER SOLID OBJECTS
        //Dash collision check for oDmg1 = can't dash through object oDmg1
        for(var i = 0;i<dashDistance;i++)//If i is smaller than Distance = add 1 to i but keep i the same, until i is = to dashDistance.
        {
            //Collision:
            if (place_meeting(oTest.x + sign(hsp) + sign(hsp)*(i*gridSize), oTest.y + sign(vsp) + sign(vsp)*(i*gridSize), oDmg1))
                {
                    tempDashDistance = i; // If there's a wall before we can finish dashing, shorten the dash distance (using temporary variable)
					break;
			   }   		
			
		  }  
		  */		    
                
		//Set hsp and vsp again and dash
        hsp = lengthdir_x(tempDashDistance * gridSize, moveDirection * 90);
        vsp = lengthdir_y(tempDashDistance * gridSize, moveDirection * 90);
        return;
		        
    }
		
	//Collisions for normal movement		
	if (vsp !=0 or hsp !=0)//If is moving:
	{
			//Collision check
	if (place_meeting(oTest.x + sign(hsp),oTest.y + sign(vsp),oWall))
			{
					//if colliding, set state to idle and reset horizontal & vertical speeds
				state = states.idle;
				hsp = 0;
				vsp = 0; 
				
			}
		
	//Collision with oDmg1 does 1 dmg
	if (place_meeting(oTest.x + sign(hsp), oTest.y + sign(vsp),oDmg1))
		{
		playerHealth = playerHealth - 1;
		}	
	
	//Collision with oHazard block kills the player 
	if (place_meeting(oTest.x + sign(hsp), oTest.y + sign(vsp),oHazard))
		{
		state = states.death;
		state_death()
	
		}
						
	else state = states.move;
				
		}
	
	/*  This code doesn't do ANYTHING?!
	else 
	{
		state = states.idle;	
	}
	*/
		
}