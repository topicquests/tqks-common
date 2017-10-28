/*
 * Copyright 2015, TopicQuests
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



/**
 * @author park
 *
 */
public class TicketPojo implements ITicket {
	private Map<String,Object>data;
	private final String
		MEMBER_KEY		= "memberlist",
		AVATAR_KEY		= "avatarlist",
		LOCATOR_KEY		= "locator";

	/**
	 * 
	 */
	public TicketPojo() {
		data = new HashMap<String,Object>();
		
	}
	
	public TicketPojo(String userLocator) {
		data = new HashMap<String,Object>();
		data.put(LOCATOR_KEY, userLocator);
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

}
