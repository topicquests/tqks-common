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
package org.topicquests.ks;

import java.util.*;

import org.topicquests.ks.api.ITQCoreOntology;
import org.topicquests.ks.api.ITicket;

public class TicketPojo implements ITicket {
  private Map<String,Object>data;
  private final String
  MEMBER_KEY		= "memberlist",
    AVATAR_KEY		= "avatarlist",
    LOCATOR_KEY		= "locator",
    HANDLE_KEY		= "handle",
    EMAIL_KEY           = "email",
    LANGUAGE_KEY        = "language",
    FIRST_NAME_KEY      = "firstName",
    LAST_NAME_KEY       = "lastName",
    ACTIVE_KEY          = "active";

  public TicketPojo() {
    data = new HashMap<String,Object>();
  }
	
  public TicketPojo(String userLocator) {
    data = new HashMap<String,Object>();
    setUserLocator(userLocator);
  }

  public TicketPojo(String userLocator, String email, String password,
                    String handle) {
    this(userLocator, email, password, handle, null, null);
  }

  public TicketPojo(String userLocator, String email, String password,
                    String handle, String first_name, String last_name) {
    this(userLocator, email, password, handle, first_name, last_name, "en");
  }

  public TicketPojo(String userLocator, String email, String password,
                    String handle, String first_name, String last_name,
                    String language) {
    data = new HashMap<String,Object>();
    setUserLocator(userLocator);
    setEmail(email);
    setHandle(handle);
    setFirstName(first_name);
    setLastName(last_name);
    setLanguage(language);
    setActive(true);
  }

  /* (non-Javadoc)
   * @see org.topicquests.model.api.ITicket#setUserLocator(java.lang.String)
   */
  @Override
  public void setUserLocator(String locator) {
    data.put(LOCATOR_KEY, locator);
  }

  /* (non-Javadoc)
   * @see org.topicquests.model.api.ITicket#getUserLocator()
   */
  @Override
  public String getUserLocator() {
    return (String)data.get(LOCATOR_KEY);
  }

  @Override
  public void setEmail(String email) {
    data.put(EMAIL_KEY, email);
  }
  
  @Override
  public String getEmail() {
    return (String)data.get(EMAIL_KEY);
  }
  
  @Override
  public void setHandle(String handle) {
    data.put(HANDLE_KEY, handle);
  }
  
  @Override
  public String getHandle() {
    return (String)data.get(HANDLE_KEY);
  }
  
  @Override
  public void setFirstName(String firstName) {
    data.put(FIRST_NAME_KEY, firstName);
  }
  
  @Override
  public String getFirstName() {
    return (String)data.get(FIRST_NAME_KEY);
  }
  
  @Override
  public void setLastName(String lastName) {
    data.put(LAST_NAME_KEY, lastName);
  }
  
  @Override
  public String getLastName() {
    return (String)data.get(LAST_NAME_KEY);
  }
  
  @Override
  public void setLanguage(String language) {
    data.put(LANGUAGE_KEY, language);
  }
  
  @Override
  public String getLanguage() {
    return (String)data.get(LANGUAGE_KEY);
  }
  
  @Override
  public void setActive(boolean active) {
    data.put(ACTIVE_KEY, new Boolean(active));
  }
  
  @Override
  public boolean getActive() {
    return ((Boolean)data.get(ACTIVE_KEY)).booleanValue();
  }

  /* (non-Javadoc)
   * @see org.topicquests.model.api.ITicket#addAvatarLocator(java.lang.String)
   */
  @Override
  public void addAvatarLocator(String avatar) {
    List<String>l = (List<String>)data.get(AVATAR_KEY);
    if (l == null) {
      l = new ArrayList<String>();
      data.put(AVATAR_KEY, l);
    }
    if (!l.contains(avatar))
      l.add(avatar);

  }

  /* (non-Javadoc)
   * @see org.topicquests.model.api.ITicket#listAvatars()
   */
  @Override
  public List<String> listAvatars() {
    List<String>l = (List<String>)data.get(AVATAR_KEY);
    if (l == null)
      l = new ArrayList<String>();
    return l;
  }

  /* (non-Javadoc)
   * @see org.topicquests.model.api.ITicket#addGroupLocator(java.lang.String)
   */
  @Override
  public void addGroupLocator(String groupLocator) {
    List<String>l = (List<String>)data.get(MEMBER_KEY);
    if (l == null) {
      l = new ArrayList<String>();
      data.put(MEMBER_KEY, l);
    }
    if (!l.contains(groupLocator))
      l.add(groupLocator);
  }

  /* (non-Javadoc)
   * @see org.topicquests.model.api.ITicket#listGroupLocators()
   */
  @Override
  public List<String> listGroupLocators() {
    List<String>l = (List<String>)data.get(MEMBER_KEY);
    if (l == null)
      l = new ArrayList<String>();
    return l;
  }

  /* (non-Javadoc)
   * @see org.topicquests.model.api.ITicket#isAuthenticated()
   */
  @Override
  public boolean isAuthenticated() {
    String lox = getUserLocator();
    return !lox.equals(ITQCoreOntology.GUEST_USER);
  }

  /* (non-Javadoc)
   * @see org.topicquests.model.api.ITicket#isMember(java.lang.String)
   */
  @Override
  public boolean isMember(String groupLocator) {
    List<String>l = listGroupLocators();
    return l.contains(groupLocator);
  }

  /* (non-Javadoc)
   * @see org.topicquests.model.api.ITicket#setProperty(java.lang.String)
   */
  @Override
  public void setProperty(String key, Object value) {
    data.put(key, value);
  }

  /* (non-Javadoc)
   * @see org.topicquests.model.api.ITicket#getProperty(java.lang.String)
   */
  @Override
  public Object getProperty(String key) {
    return data.get(key);
  }

	public Map<String, Object> getData() {
		return data;
	}

}
