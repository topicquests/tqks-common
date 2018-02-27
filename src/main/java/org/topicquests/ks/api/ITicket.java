/*
 * Copyright 2018, TopicQuests
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions
 * and limitations under the License.
 */
package org.topicquests.ks.api;

import java.util.*;

public interface ITicket {
	
  /**
   * General purpose expansion capabilities
   * @param key
   * @param value
   */
  void setProperty(String key, Object value);
  Object getProperty(String key);
	
  /**
   * <code>locator</code> is the <em>primary</em> identifier
   * for this user
   * @param locator
   */
  void setUserLocator(String locator);
  String getUserLocator();

  /**
   * <code>email</code> is the email address associated
   * with this user
   * @param email
   */
  void setEmail(String email);
  String getEmail();
  
  /**
   * <code>handle</code> is the handle associated
   * with this user
   * @param handle
   */
  void setHandle(String handle);
  String getHandle();
  
  /**
   * <code>firstName</code> is the first name of the
   * registered user
   * @param locator
   */
  void setFirstName(String firstName);
  String getFirstName();
  
  /**
   * <code>lastName</code> is the last name of the 
   * registered user
   * @param lastName
   */
  void setLastName(String lastName);
  String getLastName();
  
  /**
   * <code>language</code> is the primary language used
   * by the  user
   * @param language
   */
  void setLanguage(String language);
  String getLanguage();
  
  /**
   * <code>active</code> denotes whether the user is
   * active in the system
   * @param active
   */
  void setActive(boolean active);
  boolean getActive();
  
  /**
   * A user can have one or more, depending on system rules,
   * <code>avatar</code> identities
   * @param avatar
   */
  void addAvatarLocator(String avatar);
	
  /**
   * Return list of avatar identities
   * @return does not return <code>null</code>
   */
  List<String> listAvatars();
	
  /**
   * Some groups or documents may have ACLs which grant
   * a group identity
   * @param groupLocator
   */
  void addGroupLocator(String groupLocator);
	
  /**
   * Return a list of group locators
   * @return does not return <code>null</code>
   */
  List<String> listGroupLocators();
	
  /**
   * Will return <code>true</code> if <code>userlocator</code> is
   * not equal to {@link ITopicQuestsOntology&GUEST_USER}
   * @return
   */
  boolean isAuthenticated();
	
  /**
   * Will return <code>true</code> if this user is a has
   * <code>groupLocator</code> in the member list
   * @param groupLocator
   * @return
   */
  boolean isMember(String groupLocator);

  Map<String,Object> getData();
}
