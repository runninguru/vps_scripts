#!/bin/bash                                                  
if [ "$1" = "-n" ] #adding a new site                                               
	then                                                                          
	echo "in build a new site option"  
fi                                                                                
if [ "$1" = "-d" ] # deactivate site but keep it around                             
	then                        
	echo "deactivate a site but keep it around"
fi                                                                              
if [ "$1" = "-a" ] # reactivate a site                                            
	then 
        echo "reactivate a site"
fi
if [ "$1" = "-s" ] # create symlink for the site
	then
	echo "crete a symlink for the site"
fi
